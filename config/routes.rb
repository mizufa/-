Rails.application.routes.draw do

  devise_for :users #一番上に記述する。
  root to: "homes#top"
  get "/home/about" => "homes#about"

  resources :books, only: [:new, :index, :show, :create, :destroy, :edit, :update]
  resources :users, only: [:show, :edit, :index, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
