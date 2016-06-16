require 'test_helper'

class DailyHighLowTest < ActiveSupport::TestCase
  def setup
    @record = DailyHighLow.first
  end

  test 'db unique constraint for saved_on' do
    dup = @record.dup
    @record.save
    assert_raises('ActiveRecord::RecordNotUnique') { dup.save }
  end

  test 'null value constraing for saved_on' do
    @record.saved_on = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for one_month_high' do
    @record.one_month_high = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for one_month_low' do
    @record.one_month_low = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for three_month_high' do
    @record.three_month_high = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for three_month_low' do
    @record.three_month_low = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for six_month_high' do
    @record.six_month_high = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for six_month_low' do
    @record.six_month_low = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for twelve_month_high' do
    @record.twelve_month_high = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for twelve_month_low' do
    @record.twelve_month_low = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for ytd_high' do
    @record.ytd_high = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'null value constraint for ytd_low' do
    @record.ytd_low = ''
    assert_raises('ActiveRecord::StatementInvalid') { @record.save }
  end

  test 'data sample size from yml file' do
    assert_equal 17, DailyHighLow.count
  end

  test ':today - :yesterday one_month_high values' do
    highs = [120, 50]
    lows = [60, 30]
    assert_equal [60, 20], DailyHighLow.reduce_highs(highs, lows)
  end
end
