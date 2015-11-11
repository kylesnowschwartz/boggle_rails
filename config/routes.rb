Rails.application.routes.draw do
  resources :boards, only: [:new, :create, :show, :index]

  root to: 'boards#index'
end
