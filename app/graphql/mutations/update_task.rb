# frozen_string_literal: true

module Mutations
  class UpdateTask < BaseMutation
    field :task, Types::TaskType, null: false

    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :done, Boolean, required: false

    def resolve(**args)
      id = args.delete(:id)
      attributes = args.dup
      task = Task.where(user_id: context[:current_user].id).find(id)
      task.update!(attributes)
      { task: task }
    end
  end
end
