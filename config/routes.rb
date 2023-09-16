Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show]

  root to: "cards#index"

  resources :books do
    resources :cards
  end
  
  resources :cards
end


