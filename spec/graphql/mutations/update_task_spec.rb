# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SampleSchema mutations update_task' do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let(:mutation) do
    <<-MUTATION
      mutation(
        $id:ID!
        $title:String
        $description:String
        $done:Boolean
      ) {
        updateTask(input: {
          id: $id
          title: $title
          description: $description
          done: $done
        })
        {
          task {
            title
            description
            done
          }
        }
      }
    MUTATION
  end
  let(:variables) { { id: task.id, title: 'update' } }
  let(:context) { { current_user: user } }

  it 'updated task' do
    result = SampleSchema.execute(mutation, variables: variables, context: context)
    result_task = result['data']['updateTask']['task']
    expect(result_task['title']).to eq('update')
  end
end
