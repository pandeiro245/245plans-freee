The245plansFreee::Engine.routes.draw do
  resources :partners, only: :index
  get 'refresh_token' => 'refresh_token#index'
  get 'callback' => 'refresh_token#callback'
end
