Allaboard::Application.routes.draw do

  root  'static_pages#home'
  
  get 'boards/suggest', to: 'boards#suggest'
  devise_for :users
  match '/help',  to: 'static_pages#help', via: 'get'

  resources :users
  
  resources :reviews, only: [:new, :create]
  resources :boards do
    resources :reviews, only: [:index, :show, :new]
    get 'claim'
    post 'assign'
  end
    
end
