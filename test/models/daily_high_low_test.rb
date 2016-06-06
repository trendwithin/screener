require 'test_helper'

class DailyHighLowTest < ActiveSupport::TestCase
  def setup
    @record = DailyHighLow.new(one_month_high: 300, one_month_low: 100,
                               three_month_high: 350, three_month_low: 150,
                               six_month_high: 250, six_month_low: 75,
                               twelve_month_high: 100, twelve_month_low: 76,
                               ytd_high: 60, ytd_low: 30, saved_on: Time.now)
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

end
