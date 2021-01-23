# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SampleSchema queries task' do
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 3, user: user) }
  let(:query) do
    <<-QUERY
      query {
        tasks {
          totalCount
          edges {
            node {
              id
              title
              done
              createdAt
              updatedAt
            }
          }
        }
      }
    QUERY
  end
  let(:variables) { {} }
  let(:context) { { current_user: user } }

  it 'returns tasks' do
    result = SampleSchema.execute(query, variables: variables, context: context)
    expect(result['data']['tasks']['totalCount']).to eq(3)
    task = tasks.first
    result_task = result['data']['tasks']['edges'].first['node']
    expect(result_task['id']).to eq(task.id.to_s)
    expect(result_task['title']).to eq(task.title)
    expect(result_task['description']).to eq(task.description)
    expect(result_task['done']).to eq(task.done)
    expect(Time.zone.parse(result_task['createdAt'])).to eq(task.created_at)
    expect(Time.zone.parse(result_task['updatedAt'])).to eq(task.updated_at)
  end
end
