Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :quotes do
      resources :quotes
      get ':search_tag' => "quotes#show"
    end
  end
end
