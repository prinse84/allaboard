Allaboard::Application.routes.draw do

  root  'static_pages#home'
  
  get 'boards/suggest', to: 'boards#suggestion'
  post 'boards/suggestion/create', to: 'boards#suggestion_create'
  devise_for :users
  match '/help',  to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  post '/contact/send', to: 'static_pages#send_contact_message'

  resources :users
  
  resources :reviews, only: [:new, :create]
  resources :events, only: [:index, :show]  

  resources :reviews
  
  resources :boards, param: :slug do
    resources :reviews, only: [:index, :show, :new]
    resources :events
    get 'claim'
    get 'unclaim'
    post 'assign'
    post 'unassign'
  end
  
  resources :vendors
  resources :vendor_reviews
    
end
