# frozen_string_literal: true

module Resolvers
  class TaskResolver < GraphQL::Schema::Resolver
    type Types::TaskType, null: false

    argument :id, ID, required: true

    def resolve(id: nil)
      Task.where(user_id: context[:current_user].id).find(id)
    end
  end
end
