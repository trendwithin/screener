Rails.application.routes.draw do
  get 'all_time_highs/index'

  get 'daily_high_lows/index'

  root 'static_pages#home'
end
