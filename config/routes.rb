Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get '/book-search', to: 'book_search#index'
    end
  end

  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      resources :users, only: [:create]
    end
  end
end
