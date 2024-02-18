Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post '/signup', to: 'users#create'
      post '/login', to: 'users#login'
      resources :motorcycles
      resources :reservations
    end
  end
end
