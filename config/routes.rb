Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :update]
      resources :contracts, only: [:index, :update]
      post "/auth", to: "auth#login"
    end
  end
end
