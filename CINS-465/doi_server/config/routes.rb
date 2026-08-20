Rails.application.routes.draw do
  resources :dois do
    resources :urls, shallow: true
  end

  get 'query', to: 'home#show'

  root 'home#index'
end
