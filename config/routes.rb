Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "users/registrations" }

  resources :users, only: [:index, :show]
  resources :payments, except: [:show]

  root 'users#index'
  post 'users/update_coin', :to => 'users#update_coin'

end
