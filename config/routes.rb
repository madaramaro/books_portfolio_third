Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show, :update]

  root to: "cards#index"

  resources :books do
    resources :cards
  end
  
  resources :cards

  get 'chats', to: 'chats#index'
  get 'search', to: 'chats#search'

  resources :favorites, only: [:index, :create, :destroy]

  resources :watchlists, only: [:create, :destroy]

end

  