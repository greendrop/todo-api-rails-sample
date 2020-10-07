# frozen_string_literal: true

if ENV['RAILS_SESSION_STORE']&.upcase == 'REDIS'
  Rails.application.config.session_store(
    :redis_store,
    servers: Settings.redis.session_store.symbolize_keys,
    expire_after: Settings.session_store.expire_after
  )
else
  Rails.application.config.session_store(
    :cookie_store,
    key: '_todo-api-rails-sample_session'
  )
end
