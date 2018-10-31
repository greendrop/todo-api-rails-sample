# frozen_string_literal: true

Rails.application.routes.draw do
  get '/home', to: 'homes#index'

  devise_for :users

  namespace :api do
    namespace :v1 do
      get '/me' => 'users#me'
    end
  end

  use_doorkeeper

  root to: 'homes#index'
end
