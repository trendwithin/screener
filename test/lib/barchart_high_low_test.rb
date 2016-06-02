require 'test_helper'
require_relative '../../lib/barchart_high_low.rb'

module Barchart
  class HighLowTest < Minitest::Test
    def setup
      VCR.use_cassette('loading-barchart-high-low') do
        url = 'http://www.barchart.com/stocks/newhilo.php?dwm=d'
        html_tag = "div[id='divContent']"
        @agent = Barchart::HighLow.new
        @page = @agent.pager(url, html_tag)
      end
    end

    def test_expected_data_returns_itself
      test_agent = Barchart::HighLow.new
      source = '5'
      assert_equal source, test_agent.data_conversion(source)
    end

    def test_unexpected_data_returns_0
      test_agent = Barchart::HighLow.new
      source = %w[ 'NA' 'N/A' '' ]
      source.each do |elem|
        assert_equal '0', test_agent.data_conversion(source)
      end
    end

    # current expected data from cassette 819, 271, 476, 103, 284, 50, 140, 36, 374, 52
    def test_returned_page_for_one_month_high
      one_month_high = @agent.one_month_high(@page)
      data_point = '819'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 819, one_month_high.to_i
    end

    def test_returned_page_for_one_month_low
      one_month_low = @agent.one_month_low(@page)
      data_point = '271'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 271, one_month_low.to_i
    end

    def test_returned_page_for_three_month_high
      three_month_high = @agent.three_month_high(@page)
      data_point = '476'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 476, three_month_high.to_i
    end

    def test_returned_page_for_three_month_low
      three_month_low = @agent.three_month_low(@page)
      data_point = '103'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 103, three_month_low.to_i
    end

    def test_returned_page_for_six_month_high
      six_month_high = @agent.six_month_high(@page)
      data_point = '284'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 284, six_month_high.to_i
    end

    def test_returned_page_for_six_month_low
      six_month_low = @agent.six_month_low(@page)
      data_point = '50'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 50, six_month_low.to_i
    end

    def test_returned_page_for_twelve_month_high
      twelve_month_high = @agent.twelve_month_high(@page)
      data_point = '140'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 140, twelve_month_high.to_i
    end

    def test_returned_page_for_twelve_month_low
      twelve_month_low = @agent.twelve_month_low(@page)
      data_point = '36'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 36, twelve_month_low.to_i
    end

    def test_returned_page_for_ytd_month_high
      ytd_month_high = @agent.ytd_month_high(@page)
      data_point = '374'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 374, ytd_month_high.to_i
    end

    def test_returned_page_for_ytd_month_low
      ytd_month_low = @agent.ytd_month_low(@page)
      data_point = '52'
      assert_equal data_point, @agent.data_conversion(data_point)
      assert_equal 52, ytd_month_low.to_i
    end
  end
end
