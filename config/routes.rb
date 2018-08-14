Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :update]
      get "/contracts/incoming", to: "contracts#incoming"
      get "/contracts/outcoming", to: "contracts#outcoming"
      post "/auth", to: "auth#login"
      get "/current_user", to: 'auth#get_current_user'
    end
  end
end
