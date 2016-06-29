class DailyHighLowsController < ApplicationController
  def index
    @daily_difference = DailyHighLow.high_low_difference
  end
end
