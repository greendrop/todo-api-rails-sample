# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SampleSchema mutations create_task' do
  let(:user) { create(:user) }
  let(:mutation) do
    <<-MUTATION
      mutation(
        $title:String!
        $description:String
        $done:Boolean!
      ) {
        createTask(input: {
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
  let(:variables) { { title: 'title', description: 'description', done: true } }
  let(:context) { { current_user: user } }

  it 'created task' do
    result = SampleSchema.execute(mutation, variables: variables, context: context)
    result_task = result['data']['createTask']['task']
    expect(result_task['title']).to eq('title')
    expect(result_task['description']).to eq('description')
    expect(result_task['done']).to eq(true)
  end
end
