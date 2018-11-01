# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/api/*', headers: :any, methods: :any, expose: ['Total-Count', 'Link']
    resource '/oauth/*', headers: :any, methods: :any, expose: ['Total-Count', 'Link']
  end
end
