Allaboard::Application.routes.draw do

  root  'static_pages#home'
  
  get 'boards/suggest', to: 'boards#suggestion'
  post 'boards/suggestion/create', to: 'boards#suggestion_create'
  devise_for :users
  match '/help',  to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'

  resources :users
  
  resources :reviews, only: [:new, :create]
  resources :boards do
    resources :reviews, only: [:index, :show, :new]
    resources :events
    get 'claim'
    post 'assign'
  end
    
end
