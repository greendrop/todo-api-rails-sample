# frozen_string_literal: true

module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, GraphQL::Types::BigInt, null: false
    field :user, Types::UserType, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :done, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def user
      Loaders::AssociationLoader.for(Task, :user).load(object)
    end
  end
end
