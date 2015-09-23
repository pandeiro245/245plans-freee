HareruyaFreee::Engine.routes.draw do
  resources :partners, only: [:index, :show]
  resources :months, only: [:show]
  resources :plans, only: [:index, :show]
  get 'refresh_token' => 'refresh_token#index'
  get 'callback' => 'refresh_token#callback'
end
