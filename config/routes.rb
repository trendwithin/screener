Rails.application.routes.draw do
  get 'daily_high_lows/index'

  root 'static_pages#home'
end
