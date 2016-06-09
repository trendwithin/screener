require 'test_helper'

class BriefingsEarningTest < ActiveSupport::TestCase
  def setup
    @record = BriefingsEarning.new(symbol: "AMWD", earnings: 0.86, expectation: 0.86,
                                   year_ago_earnings: 0.68, revenue: "16.4%",
                                   saved_on: Time.now)
  end

  def test_against_duplicate_record
    dup = @record.dup
    @record.save
    assert_raises('ActiveRecord::RecordNotUnique') { dup.save }
  end
end
