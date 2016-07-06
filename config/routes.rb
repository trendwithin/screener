Rails.application.routes.draw do
  get 'briefings', to: 'briefings_earnings#index'

  get 'zacks', to: 'zacks#index'

  get 'new_highs', to: 'new_highs#index'

  get 'all_time_highs', to: 'all_time_highs#index'

  get 'daily_high_lows', to: 'daily_high_lows#index'

  root 'static_pages#home'
end
