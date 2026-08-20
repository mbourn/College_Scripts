Rails.application.routes.draw do

  devise_for :users
  resources :professors do
      resources :ratings, shallow: true
  end

  root 'professors#index'

end
