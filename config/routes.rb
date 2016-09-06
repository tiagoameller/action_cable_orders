Rails.application.routes.draw do
  root 'orders#new'

  resources :plus
  resources :orders, only: [:index, :new, :create, :show] do
    post 'serviced'
  end
end
