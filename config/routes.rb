Rails.application.routes.draw do
  root 'orders#new'

  mount ActionCable.server => '/cable'

  resources :plus
  resources :orders, only: [:index, :new, :create, :show] do
    post 'serviced'
  end
end
