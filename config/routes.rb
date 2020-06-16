Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :books, only: [:new, :create, :index, :show, :edit] do
  	resource :favorites, only: [:create, :destroy]
	resources :post_comments, only: [:create, :destroy]
	end

  root 'home#top'
  get 'home/about'
end
