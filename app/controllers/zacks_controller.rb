class ZacksController < ApplicationController
  def index
    @zacks_earnings = Zack.remove_text.surprise(params[:query]).reported
  end

  private
end
