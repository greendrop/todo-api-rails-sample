# frozen_string_literal: true

module DoorkeeperMethods
  extend ActiveSupport::Concern

  def create_doorkeeper_application
    attributes = { name: 'MyApp', redirect_uri: 'https://app.com' }
    Doorkeeper::Application.create(attributes)
  end

  def create_doorkeeper_access_token(doorkeeper_application, user, opts = {})
    attributes = { application_id: doorkeeper_application.id, resource_owner_id: user.id,
                   scopes: opts && opts[:scopes] }
    Doorkeeper::AccessToken.create(attributes)
  end
end

RSpec.configure do |config|
  config.include DoorkeeperMethods, type: :controller
  config.include DoorkeeperMethods, type: :request
end
