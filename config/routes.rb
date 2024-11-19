Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "languages#index"
  get "/:code" => "languages#show", as: :language
end
