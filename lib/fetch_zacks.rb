require 'mechanize'
module FetchZacks
  class ZacksParser

    def initialize
      @mechanize = Mechanize.new
    end

    def fetch_xls_file(url)
      @mechanize.pluggable_parser.default = Mechanize::Download
      @mechanize.get(url).save('lib/zacks_downloads/todays_earnings.xls')
    end
  end
end
