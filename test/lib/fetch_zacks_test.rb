require 'test_helper'
require_relative '../../lib/fetch_zacks.rb'

module FetchZacks
  class ZacksParserTest < Minitest::Test

    def setup
      @zacks = FetchZacks::ZacksParser.new
    end

    def test_file_downloads
      unless File.exists?('lib/zacks_downloads/todays_earnings.xls')
        @zacks.fetch_xls_file('https://www.zacks.com/research/earnings/earning_export.php')
      else
        assert_equal true, File.exists?('lib/zacks_downloads/todays_earnings.xls')
      end
    end
  end
end
