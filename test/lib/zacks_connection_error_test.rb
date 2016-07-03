# require 'test_helper'
# require_relative '../../lib/fetch_zacks.rb'
# require 'net/http'
# require 'webmock'
# include WebMock::API
#
# module Zacks
#   class ZacksConnectionErrorTest < ActiveSupport::TestCase
#     def test_connection_errs_out
#       @zacks = FetchZacks::ZacksParser.new
#       VCR.use_cassette('download-zacks-file') do
#         url = 'https://www.zacks.com/research/earnings/earning_export.php'
#         file = 'lib/zacks_downloads/todays_earnings.xls'
#         @response = Net::HTTP.get_response(URI(url))
#         stub_request(:fetch_xls_file, url).to_raise('Error').to_raise('Error').to_return()
#         @zacks.fetch_xls_file(url)
#       end
#     end
#   end
# end
