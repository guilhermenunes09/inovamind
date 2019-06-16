Rails.application.routes.draw do
  namespace :api do
    namespace :quotes do
      resources :quotes
      get ':search_tag' => "quotes#show"
    end
  end

  post 'auth/register', to: 'users#register'
  get 'login', to: 'sessions#new' # Login no Browser
  post 'auth/login', to: 'users#login' # Login na API

  root to: 'quotes#show'

  
end
