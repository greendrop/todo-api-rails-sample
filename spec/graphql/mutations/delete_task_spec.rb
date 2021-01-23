# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SampleSchema mutations delete_task' do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let(:mutation) do
    <<-MUTATION
      mutation(
        $id:ID!
      ) {
        deleteTask(input: {
          id: $id
        })
        {
          task {
            id
          }
        }
      }
    MUTATION
  end
  let(:variables) { { id: task.id } }
  let(:context) { { current_user: user } }

  it 'deleted task' do
    result = SampleSchema.execute(mutation, variables: variables, context: context)
    result_task = result['data']['deleteTask']['task']
    expect(result_task['id']).to eq(task.id.to_s)
  end
end
