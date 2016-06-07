require 'test_helper'
require_relative '../../lib/barchart_all_time_high.rb'

module Barchart
  class AllTimeHighTest < Minitest::Test
    def setup
      VCR.use_cassette('loading-barchart-all-time-high') do
        url = 'http://www.barchart.com/stocks/athigh.php'
        # html_tag = "table[class='datatable ajax']"
        html_tag = 'input'
        @agent = Barchart::AllTimeHigh.new
        @page = @agent.pager(url, html_tag)
      end
    end

    def test_return_all_time_high_symbols
      total_symbols = @page[6].to_s.scan(/[A-Z]+,[^a-z]+[A-Z]/)
      tickers = total_symbols[0].split(',')
      assert_equal 100, tickers.count
      assert_equal true, tickers.include?('ACN')
      assert_equal true, tickers.include?('VAL')
    end
  end
end
