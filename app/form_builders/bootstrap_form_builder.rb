# frozen_string_literal: true

class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Context
  include EmailField
  include FileField
  include NumberField
  include PasswordField
  include Select
  include TextArea
  include TextField

  private

  def error_attribute(method, error_options)
    error_options.delete(:attribute) || method
  end

  def field_name(method)
    "#{@object_name}[#{method}]"
  end

  def error_message_on(method, _options = {})
    errors = @object.errors
    return unless errors.include?(method)

    messages = errors[method].map { |message| errors.full_message(method, message) }

    conents = messages.each_with_object([]) do |message, objects|
      objects << @template.content_tag(:div, class: 'invalid-feedback') do
        @template.nl2br(message)
      end
    end
    safe_join(conents)
  end
end
