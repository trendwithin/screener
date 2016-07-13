require 'test_helper'
require_relative '../../../lib/barchart_scripts/barchart_new_high.rb'

module Barchart
  class NewHighTest < ActiveSupport::TestCase
    def setup
      VCR.use_cassette('loading-barchart-new-high') do
        url = "http://www.barchart.com/stocks/high.php"
        html_tag = 'input'
        @agent = Barchart::NewHigh.new
        @page = @agent.paging(url, html_tag)
        # @page = @agent.html_tagging(html_tag)
      end
    end

    def test_return_new_high_symbols
      total_symbols = @agent.extract_tickers(@page)
      assert_equal 100, total_symbols.count
    end

    def test_insertion_of_symbols
      total_symbols = @page[6].to_s.scan(/[A-Z]+,[^a-z]+[A-Z]/)
      tickers = total_symbols[0].split(',')
      @agent.insert_new_highs(tickers)
      assert_equal 104, ::NewHigh.all.count
    end
  end
end
