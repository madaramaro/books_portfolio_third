Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :users do
    resources :lists, only: [:index]
  end
  

  root to: "cards#index"
  
  resources :books do
    resources :cards, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  # resources :cards, except: [:index, :show, :new, :create] # こちらはコメントアウトまたは削除
  
  get 'chats', to: 'chats#index'
  get 'search', to: 'chats#search'

  resources :favorites, only: [:index, :create, :destroy]
  resources :watchlists, only: [:create, :destroy]
  
  resources :cards, only: [:index] do
    resource :like, only: [:create, :destroy]
  end

  resources :search_histories, only: [:index]

  resources :lists, only: [:index, :new, :create, :edit, :update, :destroy, :show]

end
