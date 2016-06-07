require 'test_helper'

class AllTimeHighTest < ActiveSupport::TestCase
  def setup
    @ath = AllTimeHigh.new(symbol: 'AAPL', saved_on: Time.now)
  end

  test 'uniqueness of symbol/saved_on' do
    dup = @ath.dup
    @ath.save
    assert_raises('ActiveRecord::RecordNotUnique') { dup.save }
  end

  test 'symbol/saved_on concurrent days' do
    count = AllTimeHigh.all.count
    dup = @ath.dup
    dup.saved_on = 1.day.ago
    dup.save
    assert @ath.save
    assert_equal count + 2, AllTimeHigh.all.count
  end

  test 'empty symbol' do
    @ath.symbol = ''
    assert_raises('RuntimeError') { @ath.save }
  end

  test 'empty saved_on' do
    @ath.saved_on = ''
    assert_raises('RuntimeError') { @ath.save }
  end

  test 'flow with empty symbol' do
    count = AllTimeHigh.all.count
    symbols = ['AAPL', 'GOOG', "", 'XYZ']
    symbols.each do |s|
      if s.blank?
        assert_raises('RuntimeError') { AllTimeHigh.create(symbol: s, saved_on: Time.now) }
      else
        AllTimeHigh.create!(symbol: s, saved_on: Time.now)
      end
    end
    assert_equal count + 3, AllTimeHigh.count
  end
end
