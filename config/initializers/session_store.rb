# frozen_string_literal: true

if Rails.env.test?
  Rails.application.config.session_store(
    :cookie_store,
    key: '_todo-pwa-sample_session'
  )
else
  Rails.application.config.session_store(
    :redis_store,
    servers: Settings.redis.session_store.symbolize_keys,
    expire_after: Settings.session_store.expire_after
  )
end
