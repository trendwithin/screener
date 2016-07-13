class NewHighsController < ApplicationController
  def index
    if params[:query].present?
      time_period = query_time_period(params[:query])
      @new_highs = NewHigh.period(time_period).by_symbol.ordered_by
      byebug
    else
      @new_highs = NewHigh.monthly.by_symbol.ordered_by
    end
  end

  private
    def query_time_period(query)
      if query == 'bi_weekly'
        2.weeks.ago
      elsif query == 'weekly'
        1.week.ago
      else
        1.month.ago
      end
    end
end
