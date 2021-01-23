# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SampleSchema queries task' do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let(:query) do
    <<-QUERY
      query($id:ID!) {
        task(id: $id) {
          id
          title
          description
          done
          createdAt
          updatedAt
        }
      }
    QUERY
  end
  let(:variables) { { id: task.id } }
  let(:context) { { current_user: user } }

  it 'returns task' do
    result = SampleSchema.execute(query, variables: variables, context: context)
    result_task = result['data']['task']
    expect(result_task['id']).to eq(task.id.to_s)
    expect(result_task['title']).to eq(task.title)
    expect(result_task['description']).to eq(task.description)
    expect(result_task['done']).to eq(task.done)
    expect(Time.zone.parse(result_task['createdAt'])).to eq(task.created_at)
    expect(Time.zone.parse(result_task['updatedAt'])).to eq(task.updated_at)
  end
end
