# frozen_string_literal: true

module Api
  class UserSerializer < BaseSerializer
    attributes :id, :email, :created_at, :updated_at
    attribute :errors, if: -> { instance_options[:with_errors] }

    def errors
      validate_errors(object)
    end
  end
end
