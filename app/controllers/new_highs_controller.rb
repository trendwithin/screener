class NewHighsController < ApplicationController
  def index
    @monthly_new_highs = NewHigh.monthly.by_symbol.ordered_by
  end
end
