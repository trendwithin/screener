require 'test_helper'
require_relative '../../lib/fetch_briefings.rb'
require 'net/http'
require 'webmock'
include WebMock::API

module Briefings
  class BriefingsConnectionErrorTest < ActiveSupport::TestCase
    def test_new_high_connection_errs_out
      VCR.use_cassette('loading-briefings-earnings') do
        url = 'http://hosting.briefing.com/cschwab/Calendars/EarningsCalendar5Weeks.htm'
        html_tag = ".//table[@width='100%']"
        @agent = Briefings::Earnings.new
        stub_request(:paging, url).to_raise('Error').to_raise('Error').to_return()
        @agent.paging(url)
      end
    end
  end
end
