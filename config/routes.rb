Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create], path: 'signup'
      resources :reservations
      resources :motorcycles
      post '/login', to: 'authentication#login', default: {format: :json}
    end
  end
end
