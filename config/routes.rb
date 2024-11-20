Rails.application.routes.draw do
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root "languages#index"
  get "/:code" => "languages#show", as: :language
  get "/:code/:title" => "pages#show", as: :page
end
