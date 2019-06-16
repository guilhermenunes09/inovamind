Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :quotes do
      resources :quotes
      get ':search_tag' => "quotes#show"
    end
  end


  post 'auth/register', to: 'users#register'
  get 'login', to: 'sessions#new'
  post 'auth/login', to: 'users#login'
  get 'test', to: 'users#test'

  root to: 'quotes#show'
  
end
