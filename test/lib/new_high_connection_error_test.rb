# require 'test_helper'
# require_relative '../../lib/barchart_new_high.rb'
# require 'net/http'
# require 'webmock'
# include WebMock::API
#
# module Barchart
#   class NewHighConnectionErrorTest < ActiveSupport::TestCase
#     def test_new_high_connection_errs_out
#       VCR.use_cassette('loading-barchart-new-high') do
#         url = "http://www.barchart.com/stocks/high.php"
#         html_tag = 'input'
#         @agent = Barchart::NewHigh.new
#         stub_request(:paging, url).to_raise('Error').to_raise('Error').to_return()
#         @agent.paging(url)
#         # @page = @agent.pager(url, html_tag)
#       end
#     end
#   end
# end
