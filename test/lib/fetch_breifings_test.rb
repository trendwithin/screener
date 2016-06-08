require 'test_helper'
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
      @page.each do |node, index|
        string = node.to_s
        if string.include?('June 02')
          @found = node
        end
      end
      assert_equal false, @found.nil?
    end

    def test_parse_current_data
      node = @agent.parse_current_date_data(@page)
      assert_equal true, node.include?('June 02')
    end
  end
end
