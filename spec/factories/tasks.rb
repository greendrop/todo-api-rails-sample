# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    association :user
    sequence(:title) { |n| "title#{n}" }
  end
end
