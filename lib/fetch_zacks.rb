require 'mechanize'
require 'csv'

module FetchZacks
  class ZacksParser
    def initialize
      @mechanize = Mechanize.new
    end

    def fetch_xls_file(url)
      @mechanize.pluggable_parser.default = Mechanize::Download
      @mechanize.get(url).save('lib/zacks_downloads/todays_earnings.xls')
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

    def insert_zacks_data
      CSV.foreach('lib/zacks_downloads/todays_earnings.xls', col_sep: "\t", headers: true, header_converters:  lambda { |h| h.try(:downcase) }) do |row|
        hash = row.to_hash
        hash.delete(nil)
        hash['report_time'] = hash.delete('report time')
        hash['price_pct_change'] = hash.delete('price % change')
        hash['current_price'] = hash.delete('current price')
        Zack.create!(hash)
      end
    end
  end
end
