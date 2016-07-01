require 'test_helper'
require 'support/fetch_briefings_support'
require_relative '../../lib/barchart_all_time_high.rb'

module Barchart
    class AllTimeHighTest < ActiveSupport::TestCase
    def setup
      VCR.use_cassette('loading-barchart-all-time-high') do
        url = 'http://www.barchart.com/stocks/athigh.php'
        html_tag = 'input'
        @agent = Barchart::AllTimeHigh.new
        @agent.paging(url)
        @page = @agent.html_tagging(html_tag)
      end
    end

    def test_200_status_code
      assert_equal '200', @agent.mechanize.page.code
    end

    def test_return_all_time_high_symbols
      total_symbols = @page[6].to_s.scan(/[A-Z]+,[^a-z]+[A-Z]/)
      tickers = total_symbols[0].split(',')
      assert_equal 100, tickers.count
      assert_equal true, tickers.include?('ACN')
      assert_equal true, tickers.include?('VAL')
    end

    def test_insertion_of_symbols
      total_symbols = @page[6].to_s.scan(/[A-Z]+,[^a-z]+[A-Z]/)
      tickers = total_symbols[0].split(',')
      @agent.insert_all_time_highs(tickers)
      assert_equal 100, ::AllTimeHigh.all.count
    end
  end
end
