# frozen_string_literal: true

class BootstrapFormBuilder
  module Select
    extend ActiveSupport::Concern

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      options = {
        error_options: {}
      }.merge(options)
      html_options = {
        class: 'form-control'
      }.merge(html_options)
      error_options = options.delete(:error_options)
      attribute = error_attribute(method, error_options)
      html_options[:class] += ' is-invalid' if @object.errors.include?(attribute)
      super + error_message_on(attribute, error_options)
    end

    def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
      options = {
        error_options: {}
      }.merge(options)
      html_options = {
        class: 'form-control'
      }.merge(html_options)
      error_options = options.delete(:error_options)
      attribute = error_attribute(method, error_options)
      html_options[:class] += ' is-invalid' if @object.errors.include?(attribute)
      super + error_message_on(attribute, error_options)
    end
  end
end
