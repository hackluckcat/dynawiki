Rails.application.routes.draw do
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root "languages#index"
  get "/:code" => "languages#show", as: :language
  get "/:code/legals" => "legals#index", as: :legals
  get "/:code/wiki/:title" => "pages#show", as: :page, constraints: { title: /.+/ }
end
