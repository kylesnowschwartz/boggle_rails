Rails.application.routes.draw do
  resources :boards, only: [:new, :create, :show, :index] do
    resources :words, only: :create
  end

  root to: 'boards#index'
end
