Rails.application.routes.draw do

  devise_for :users, controllers: { :registrations => "users/registrations" }

  resource  :users, only: [:show]
  resources :payments, except: [:show]

  root 'welcome#index'

  post 'users/update_coin', :to => 'users#update_coin'
  get  'users/graphic_data', :defaults => { :format => 'json' }
end
