require 'mechanize'
require 'csv'

module FetchZacks
  class ZacksParser
    attr_reader :mechanize
    def initialize
      @mechanize = Mechanize.new
      @mechanize.pluggable_parser.default = Mechanize::Download
      @file = 'lib/zacks_downloads/todays_earnings.xls'
    end

    def fetch_xls_file(url, tries: 3)
      # RubyTapas EP 257
      @mechanize.get(url).save!('lib/zacks_downloads/todays_earnings.xls')
      rescue => e
        Rails::logger.error "There was an Error Processing Zacks Download: #{e}"
        tries -= 1
        if tries > 0
          retry
        else
          raise e
        end
    end

    def read_file
      raise 'File Not Found' unless File.exist?('lib/zacks_downloads/todays_earnings.xls')
      data_collection = Array.new(0)
      File.open('lib/zacks_downloads/todays_earnings.xls') do |file|
        file.map do |line|
          data_collection << line.strip.split("\t")
        end
      end
      data_collection
    end

    def file_size
      raise 'File Not Found' unless File.exist?(@file)
      File.size(@file)
    end

    def verify_file_size(file_size)
      flag = false
      3.times do
        break if flag = file_size == File.size(@file)
        sleep 2
        file_size = File.size(@file)
      end
      flag
    end

    def verify_file_creation_time?
      Time.now.to_date == File.ctime(@file).to_date
    end

    def insert_zacks_data
      clean_headers = lambda do |header|
        return 'price_pct_change' if header == 'Price % Change'
        header.gsub!(/\s/, '_')
        return header.downcase!
      end

      CSV.foreach('lib/zacks_downloads/todays_earnings.xls', col_sep: "\t", headers: true, header_converters: clean_headers) do |row|
        hash = row.to_hash
        hash.delete(nil)
        ::Zack.create!(hash)
      end
    end
  end
end
