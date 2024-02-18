Rails.application.routes.draw do
  #devise_for :users

  namespace :api do
    namespace :v1 do
      post '/signup', to: 'users#create'
      post '/login', to: 'users#login'
      resources :motorcycles
    end
  end
end
