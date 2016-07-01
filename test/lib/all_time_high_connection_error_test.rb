require 'test_helper'
require_relative '../../lib/barchart_new_high.rb'
require 'net/http'
require 'webmock'
include WebMock::API

module Barchart
  class AllTimeHighConnectionErrorTest < ActiveSupport::TestCase
    def test_all_time_high_connection_errs_out
      VCR.use_cassette('loading-barchart-all-time-high') do
        url = "http://www.barchart.com/stocks/athigh.php"
        html_tag = 'input'
        @agent = Barchart::AllTimeHigh.new
        stub_request(:paging, url).to_raise('Error').to_raise('Error').to_return(body: 'OK')
        @agent.paging(url)
      end
    end
  end
end
