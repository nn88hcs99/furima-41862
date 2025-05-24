Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
   resources :items, only: [:new, :create] do

    #resources :orders,only: :create
    #collection do
      #get 'search'
    #end  
  
  #resources :users, only: :show
 end 
 end