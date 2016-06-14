class DailyHighLow < ActiveRecord::Base

  private
  def self.reduce_highs(highs, lows)
    highs.zip(lows).map { |h, l| h - l }
  end
end
