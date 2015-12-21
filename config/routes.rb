Allaboard::Application.routes.draw do

  root  'static_pages#home'

  get 'boards/suggest', to: 'boards#suggestion'
  post 'boards/suggestion/create', to: 'boards#suggestion_create'
  devise_for :users
  match '/help',  to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  post '/contact/send', to: 'static_pages#send_contact_message'
  match '/existing', to: 'static_pages#existing_members', via: 'get'
  match '/interested', to: 'static_pages#interested_member', via: 'get'

  resources :users
  resources :parent_organizations do
    collection do
      post 'import'
    end
  end

  resources :reviews, only: [:new, :create]
  resources :events, only: [:index, :show], param: :slug
  resources :reviews
  #resources :comments, :only => [:destroy, :show, :edit, :update]

  resources :articles, param: :slug do
    resources :comments, :only => [:create, :new]
  end

  resources :categories
  resources :announcements, only: [:index]

  resources :boards, param: :slug do
    resources :reviews, only: [:index, :show, :new]
    resources :events, param: :slug
    resources :announcements
    get 'claim'
    get 'unclaim'
    post 'assign'
    post 'unassign'
  end

  resources :vendors
  resources :vendor_reviews

end
