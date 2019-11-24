# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/api/*', headers: :any, methods: :any, expose: %w[Total-Count Link]
    resource '/auth/oauth/*', headers: :any, methods: :any, expose: %w[Total-Count Link]
    resource '/docs/*', headers: :any, methods: :any if Rails.env.development?
  end
end
