require 'test_helper'

class NewHighTest < ActiveSupport::TestCase
  def setup
    @nh = NewHigh.new(symbol: 'AAPL', saved_on: Time.now)
  end

  test 'uniqueness of symbol/saved_on' do
    dup = @nh.dup
    @nh.save
    assert_raises('ActiveRecord::RecordNotUnique') { dup.save }
  end

  test 'symbol/saved_on concurrent days' do
    count = NewHigh.all.count
    dup = @nh.dup
    dup.saved_on = 1.day.ago
    dup.save
    assert @nh.save
    assert_equal count + 2, NewHigh.all.count
  end

  test 'empty symbol' do
    @nh.symbol = ''
    assert_raises('RuntimeError') { @nh.save }
  end

  test 'empty saved_on' do
    @nh.saved_on = ''
    assert_raises('RuntimeError') { @nh.save }
  end

  test 'flow with empty symbol' do
    count = NewHigh.all.count
    symbols = ['AAPL', 'GOOG', "", 'XYZ']
    symbols.each do |s|
      if s.blank?
        assert_raises('RuntimeError') { NewHigh.create(symbol: s, saved_on: Time.now) }
      else
        NewHigh.create!(symbol: s, saved_on: Time.now)
      end
    end
    assert_equal count + 3, NewHigh.count
  end
end
