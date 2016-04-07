Rails.application.routes.draw do
  get 'posts/index'
  resources :posts


  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root 'bets#index'
  devise_for :users
  resources :bets do
    collection do
      get 'my'
      get 'inactive'
      get 'finished'
    end
    member do
      get 'join'
    end
  end


end
