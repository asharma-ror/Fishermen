Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  namespace :api do
    namespace :v1 do
      resources :monsters
      resources :teams
    end
  end

  root 'home#index'
  resources :monsters
  resources :teams

end
