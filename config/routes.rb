Rails.application.routes.draw do
  get 'zacks/index'

  get 'new_highs/index'

  get 'all_time_highs/index'

  get 'daily_high_lows/index'

  root 'static_pages#home'
end
