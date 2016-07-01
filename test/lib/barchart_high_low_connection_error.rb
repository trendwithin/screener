require 'test_helper'
require_relative '../../lib/barchart_new_high.rb'
require 'net/http'
require 'webmock'
include WebMock::API

module Barchart
  class BarchartHighLowConnectionErrorTest < ActiveSupport::TestCase
    def test_barchart_high_low_connection_errs_out
      VCR.use_cassette('loading-barchart-high-low') do
        url = 'http://www.barchart.com/stocks/newhilo.php?dwm=d'
        html_tag = "div[id='divContent']"
        @agent = Barchart::HighLow.new
        stub_request(:paging, url).to_raise('Error').to_raise('Error').to_return()
        @agent.paging(url)
      end
    end
  end
end
