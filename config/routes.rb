Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :palates, only: [:index, :show]
      post 'users/:id/palates', to: 'palates#create'
      get 'users/:id/palates', to: 'palates#user_palates'
      post 'login', to: 'auth#create'
    end
  end
end