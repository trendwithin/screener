class BriefingsEarningsController < ApplicationController
  def index
    @briefings_earnings = BriefingsEarning.all
  end
end
