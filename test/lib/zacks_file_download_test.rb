require 'test_helper'
require_relative '../../lib/fetch_zacks.rb'
module Zacks
  class ZackFileDownloadTest < ActiveSupport::TestCase
    def setup
      @zacks = FetchZacks::ZacksParser.new
      VCR.use_cassette('download-zacks-file') do
        url = 'https://www.zacks.com/research/earnings/earning_export.php'
        @response = Net::HTTP.get_response(URI(url))
        @zacks.fetch_xls_file(url)
      end
    end

    def test_200_status_code
      assert_equal "200", @response.code
    end

    def test_file_size
      file_size = File.size('lib/zacks_downloads/todays_earnings.xls')
      assert_equal file_size, @zacks.file_size
    end

    def test_verify_file_size
      file_size = 1600
      assert_equal true, @zacks.verify_file_size(file_size)
    end

    def test_verify_file_date
      # File Testing Date 2016-06-29
      test_file_created = Time.local(2016, 6, 30, 12, 0, 0)
      Timecop.freeze(test_file_created) do
        file_created_on = File.ctime('lib/zacks_downloads/todays_earnings.xls')
        assert_equal true, @zacks.verify_file_creation_time?
      end
    end

    def test_verify_date_when_file_date_different
      test_file_created = Time.local(2016, 6, 30, 12, 0, 0)
      Timecop.freeze(test_file_created + 1.day) do
        file_created_on = File.ctime('lib/zacks_downloads/todays_earnings.xls')
        assert_equal false, @zacks.verify_file_creation_time?
      end
    end
  end
end
