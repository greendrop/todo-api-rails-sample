# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    private

    def index_total_count_header(records)
      records.total_count.to_s
    end

    def index_link_header(records)
      index_link_header_fields(records).join(', ')
    end

    def index_link_header_fields(records)
      [
        index_link_header_first_field(records),
        index_link_header_previous_field(records),
        index_link_header_next_field(records),
        index_link_header_last_field(records)
      ].compact
    end

    def index_link_header_first_field(_records)
      url = url_for(request.query_parameters.merge(
                      only_path: false, Kaminari.config.page_method_name => 1
                    ))
      %(<#{url}>; rel="first")
    end

    def index_link_header_previous_field(records)
      return if records.first_page?

      url = url_for(request.query_parameters.merge(
                      only_path: false, Kaminari.config.page_method_name => records.prev_page
                    ))
      %(<#{url}>; rel="prev")
    end

    def index_link_header_next_field(records)
      return if records.last_page?

      url = url_for(request.query_parameters.merge(
                      only_path: false, Kaminari.config.page_method_name => records.next_page
                    ))
      %(<#{url}>; rel="next")
    end

    def index_link_header_last_field(records)
      url = url_for(request.query_parameters.merge(
                      only_path: false, Kaminari.config.page_method_name => records.total_pages
                    ))
      %(<#{url}>; rel="last")
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
