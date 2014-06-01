Allaboard::Application.routes.draw do

  root  'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  resources :reviews, only: [:new, :create]
  resources :boards do
    resources :reviews, only: [:index]
  end
    
end
