class BriefingsEarningsController < ApplicationController
  def index
    @briefings_earnings = BriefingsEarning.earnings.expectation.surprise(params[:query])
  end
end
