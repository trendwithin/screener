require 'test_helper'

class ZackTest < ActiveSupport::TestCase

  test 'query to return values > 25' do
    records = Zack.remove_text.surprise(25).reported
    records.each do |elem|
      assert_equal true, elem[:surprise].to_i > 25
    end
  end
end
