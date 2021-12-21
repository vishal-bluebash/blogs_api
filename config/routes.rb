# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: redirect("/api-docs")

  get "/version", to: "version#show"

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end
  namespace :auth do
    resources :sessions, only: [:create]
  end

  # use a custom exception instead of ActionController::RoutingError
  match "*unmatched", to: "application#route_not_found", via: :all, constraints: lambda { |req|
    req.path.exclude? "rails/active_storage"
  }
end
