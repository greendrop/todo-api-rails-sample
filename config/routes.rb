# frozen_string_literal: true

require_relative 'routes/api'

Rails.application.routes.draw do
  # Auth
  scope :auth do
    devise_for :users,
               controllers: {
                 registrations: 'auth/users/registrations',
                 passwords: 'auth/users/passwords',
                 sessions: 'auth/users/sessions',
                 unlocks: 'auth/users/unlocks'
               }

    use_doorkeeper
  end

  # Api
  namespace :api, path: :api, as: :api do
    extend RoutesApi
  end

  get '/home', to: 'homes#index'
  root to: 'homes#index'

  # Docs
  get '/docs/*path', to: 'docs#show' if Rails.env.development?

  # Swagger
  get 'swagger', to: 'swaggers#show' if Rails.env.development?

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
