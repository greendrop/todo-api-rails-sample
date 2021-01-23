# frozen_string_literal: true

module Mutations
  class CreateTask < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end

    field :task, Types::TaskType, null: false

    argument :title, String, required: true
    argument :description, String, required: false
    argument :done, Boolean, required: true

    def resolve(**args)
      attributes = args.dup
      attributes[:user_id] = context[:current_user].id
      task = Task.create!(attributes)
      { task: task }
    end
  end
end
