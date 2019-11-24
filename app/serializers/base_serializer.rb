# frozen_string_literal: true

class BaseSerializer < ActiveModel::Serializer
  private

  def validate_errors(record)
    errors = record.errors
    errors.messages.keys.each_with_object({}) do |attribute, objects|
      objects[attribute] = errors[attribute].map { |message| errors .full_message(attribute, message) }
    end
  end
end
