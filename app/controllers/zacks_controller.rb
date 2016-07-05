class ZacksController < ApplicationController
  def index
    @zacks_earnings = Zack.all.limit(10)
  end
end
