Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get 'login', action: :index, controller: 'login'
  # get 'login', to: 'login#index'

  # resources :locations, except: [:show, :index]
  # resources :locations
  # resources :characters

  resources :locations do
    resources :characters
  end
end
