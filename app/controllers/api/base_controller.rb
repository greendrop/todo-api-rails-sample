# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    include ApiResponseRenderable
    include ApiExceptionRescuable

    skip_before_action :verify_authenticity_token

    private

    def paging_by_kaminari(records)
      {
        total_count: records.total_count,
        limit_value: records.limit_value,
        total_pages: records.total_pages,
        current_page: records.current_page
      }
    end

    def validate_errors(records)
      errors = records.errors
      errors.messages.keys.each_with_object({}) do |attribute, objects|
        objects[attribute] = errors[attribute].map { |message| errors .full_message(attribute, message) }
      end
    end

    def page_param
      params[Kaminari.config.page_method_name] || 1
    end

    def per_page_param
      params[:per_page] || Kaminari.config.default_per_page
    end
  end
end
