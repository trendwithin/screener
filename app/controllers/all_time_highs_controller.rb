class AllTimeHighsController < ApplicationController
  def index
    @monthly_all_time_highs = AllTimeHigh.monthly.by_symbol.ordered_by
  end
end
