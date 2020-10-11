# frozen_string_literal: true

module ApiExceptionRescuable
  extend ActiveSupport::Concern

  include ApiResponseRenderable

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::InvalidAuthenticityToken, with: :render_forbidden
    rescue_from ActionController::UnpermittedParameters, with: :render_bad_request
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
  end
end
