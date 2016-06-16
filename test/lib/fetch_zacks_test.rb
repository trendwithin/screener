require 'test_helper'
require_relative '../../lib/fetch_zacks.rb'

module FetchZacks
  class ZacksParserTest < ActiveSupport::TestCase

    def setup
      @zacks = FetchZacks::ZacksParser.new
      @url = 'lib/zacks_downloads/todays_earnings.xls'
    end

    def test_file_downloads
      unless File.exist?('lib/zacks_downloads/todays_earnings.xls')
        @zacks.fetch_xls_file('https://www.zacks.com/research/earnings/earning_export.php')
      end
      assert_equal true, File.exist?('lib/zacks_downloads/todays_earnings.xls')
    end

    def test_file_read_returns_array_of_data
      data = @zacks.read_file
      assert_equal Array, data.class
      assert_equal 28, data.size
    end

    def test_subarrays_of_valid_length
      data = @zacks.read_file
      data.each do |sub|
        assert_equal 8, sub.length
      end
    end

    def test_expected_format_for_data
      data = @zacks.read_file
      data.each do |sub|
        unless sub[0] == 'Symbol'
          assert sub[0] =~ /[a-zA-z]{1,6}/, "#{sub[0]} should be valid"
          refute /[-+]?[0-9]*\.?[0-9]+/.match(sub[4]).nil?, "#{sub[4]} should be valid"
        end
      end
    end

    def test_insertion_of_data
      current_data = Zack.all.count
      data = @zacks.read_file.count - 1
      @zacks.insert_zacks_data
      assert_equal current_data + data, Zack.all.count
      record = Zack.find_by(symbol: 'VRA')
      assert_equal 'VRA', record[:symbol]
    end
  end
end
