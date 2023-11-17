Rails.application.routes.draw do
  resources :spacecrafts, only: %i[index show]
  resources :rockets, only: %i[index show create update]
  resources :ufos, only: %i[index show create update]
  resources :space_shuttles, only: %i[index show create update]

  get "up" => "rails/health#show", as: :rails_health_check
end
