# frozen_string_literal: true

module Resolvers
  class TasksResolver < GraphQL::Schema::Resolver
    type Types::TaskType.connection_type, null: false

    def resolve
      Task.where(user_id: context[:current_user])
    end
  end
end
