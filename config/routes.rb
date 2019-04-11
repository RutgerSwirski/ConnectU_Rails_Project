Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :trips do
    resources :reviews, only: :create
    resources :favourites, only: :create
  end
  resources :trip_categories

  resources :activities do
    resources :reviews, only: :create
    resources :favourites, only: :create
  end

  resources :orders, only: [:show, :create, :index] do
    resources :payments, only: [:new, :create]
  end

  resources :profiles, only: [:show, :index] do 
    resources :friends, only: :create
    resources :messages, only: :create
  end
  resources :messages, only: :index

  resources :friends, only: [:index, :update, :destroy]

  resources :flats do
    resources :reviews, only: :create
    resources :amenities, except: [:index, :show]
    resources :favourites, only: :create
  end

  resources :flat_photos, only: :destroy
  resources :trip_photos, only: :destroy
  resources :activity_photos, only: :destroy

  resources :favourites, only: [:index, :destroy]

  resources :tickets, only: [:show, :update]

  get "/my_profile", to: "profiles#my_profile", as: "my_profile"

  get "/my_hosted", to: "profiles#my_hosted", as: "my_hosted"
end
