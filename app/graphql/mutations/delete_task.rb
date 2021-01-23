# frozen_string_literal: true

module Mutations
  class DeleteTask < BaseMutation
    field :task, Types::TaskType, null: false

    argument :id, ID, required: true

    def resolve(id: nil)
      task = Task.where(user_id: context[:current_user].id).find(id)
      task.destroy!
      { task: task }
    end
  end
end
