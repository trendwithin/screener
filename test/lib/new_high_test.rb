require 'test_helper'
require_relative '../../lib/barchart_new_high.rb'

module Barchart
  class NewHighTest < Minitest::Test
    def setup
      VCR.use_cassette('loading-barchart-new-high') do
        url = "http://www.barchart.com/stocks/high.php"
        html_tag = 'input'
        @agent = Barchart::NewHigh.new
        @page = @agent.pager(url, html_tag)
      end
    end

    def test_return_new_high_symbols
      total_symbols = @agent.extract_tickers(@page)
      byebug
      assert_equal 100, total_symbols.count
    end
  end
end
