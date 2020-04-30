Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users, only: [:show,:edit,:update,:index]
  get 'home/about' => 'books#about'
  root 'books#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
