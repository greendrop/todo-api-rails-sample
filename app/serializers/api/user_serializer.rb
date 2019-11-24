# frozen_string_literal: true

module Api
  class UserSerializer < BaseSerializer
    attributes :id, :email, :created_at, :updated_at
  end
end
