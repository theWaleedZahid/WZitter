Rails.application.routes.draw do

  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts do
    resources :comments
    member do
      put "like", to: "posts#upvote"
    end
  end
  # Define Root URL
  root 'pages#index'
  
  # Define Routes for Pages
  get '/home' => 'pages#home' # override default routes.
  get '/user/:id' => 'pages#profile'
  get '/explore' => 'pages#explore'
  get '/wzeet/:id' => 'posts#show'
  get '/wzeets' => 'pages#posts'
  get '/hashtag/:name', to: 'posts#hashtags'
end
