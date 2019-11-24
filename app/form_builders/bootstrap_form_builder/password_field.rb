# frozen_string_literal: true

class BootstrapFormBuilder
  module PasswordField
    extend ActiveSupport::Concern

    def password_field(method, options = {})
      options = {
        class: 'form-control',
        error_options: {}
      }.merge(options)

      error_options = options.delete(:error_options)
      attribute = error_attribute(method, error_options)
      options[:class] += ' is-invalid' if @object.errors.include?(attribute)
      super + error_message_on(attribute, error_options)
    end
  end
end
