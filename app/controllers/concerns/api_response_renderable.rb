# frozen_string_literal: true

module ApiResponseRenderable
  extend ActiveSupport::Concern

  private

  def render_success(data, namespace: nil, include: [], options: {})
    render json: data, namespace: namespace, include: include, status: :ok, **options
  end

  def render_created(data, namespace: nil, include: [], options: {})
    render json: data, namespace: namespace, include: include, status: :created, **options
  end

  def render_no_content
    render json: { status: 204, title: 'No Content.' }, status: :no_content
  end

  def render_bad_request(data = {})
    render problem: hashed_response_data(data), status: :bad_request
  end

  def render_unauthorized(data = {})
    render problem: hashed_response_data(data), status: :unauthorized
  end

  def render_forbidden(data = {})
    render problem: hashed_response_data(data), status: :forbidden
  end

  def render_not_found(data = {})
    render problem: hashed_response_data(data), status: :not_found
  end

  def render_conflict(data = {})
    render problem: hashed_response_data(data), status: :conflict
  end

  def render_unprocessable_entity(data)
    render problem: { errors: data }, status: :unprocessable_entity
  end

  def render_error(data)
    render problem: data, status: :internal_server_error
  end

  def hashed_response_data(data)
    data.is_a?(StandardError) ? { title: data.message } : data.to_h
  end
end
