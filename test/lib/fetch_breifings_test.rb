require 'test_helper'
require 'support/database_cleaner'
require_relative '../../lib/fetch_briefings'

module Briefings
  class EarningsTest < Minitest::Test
    def setup
      VCR.use_cassette('loading-briefings-earnings') do
        url = 'http://hosting.briefing.com/cschwab/Calendars/EarningsCalendar5Weeks.htm'
        html_tag = ".//table[@width='100%']"
        @agent = Briefings::Earnings.new
        @page = @agent.pager(url, html_tag)
      end
    end

    def test_page_returns_current_date_data
      # match(//) cassette dependent
      @page.each do |node|
        string = node.to_s
        if string.include?('June 02')
          @found = node
        end
      end
      assert_equal false, @found.nil?
    end

    def test_parse_current_data
      node = @agent.parse_current_date_data(@page)
      assert_equal true, node.to_s.include?('June 02')
    end

    def test_extraction_parse_selector
      node = @agent.parse_current_date_data(@page)
      extracted_data = @agent.parse_selector(node)
      assert_equal Array, extracted_data.class
    end

    def test_format_data_from_selector
      node = @agent.parse_current_date_data(@page)
      extracted_data = @agent.parse_selector(node)
      formatted = @agent.format_parsed_selector(extracted_data)
      formatted.each do |elem|
        assert_equal 9, elem.size
      end
    end

    def test_results_data_matches_expectation
      node = @agent.parse_current_date_data(@page)
      extracted_data = @agent.parse_selector(node)
      formatted = @agent.format_parsed_selector(extracted_data)
      formatted.each do |elem|
        assert true, elem[1].match(/[A-Z a-z+]/)
        assert true, elem[2].match(/[^A-Z+$]/)
        assert true, elem[3].is_a?(Float)
        assert true, elem[5].is_a?(Float)
        assert true, elem[6].is_a?(Float)
      end
    end

    def test_insertion_raises_error_if_array_empty
      array = []
      assert_raises('Parsed Briefing Dom Returned Empty') { @agent.insert_briefings_data(array) }
    end

    def test_insertion_of_elements
      count = BriefingsEarning.all.count
      node = @agent.parse_current_date_data(@page)
      extracted_data = @agent.parse_selector(node)
      formatted = @agent.format_parsed_selector(extracted_data)
      @agent.insert_briefings_data(formatted)
      assert_equal 8, BriefingsEarning.all.count + count
    end

    def test_element_without_earnings_does_not_insert
      count = BriefingsEarning.all.count
      array = [["", "American Woodmark", "AMWD", "0.86", "a", "0.87", "0.68", "", "16.4%"],
              ["", "Conn's", "CONN", "", "", "0.12", "0.44", "", "6.6%"]]
      @agent.insert_briefings_data(array)
      assert_equal 1 + count, BriefingsEarning.all.count
    end
  end
end
