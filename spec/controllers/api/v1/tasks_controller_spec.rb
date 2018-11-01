# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:doorkeeper_application) { create_doorkeeper_application }
  let(:access_token) { create_doorkeeper_access_token(doorkeeper_application, user) }

  describe 'GET index' do
    let!(:tasks) { create_list(:task, 3, user_id: user.id) }

    before do
      headers = { 'Authorization' => "Bearer #{access_token.token}" }
      headers.each { |key, value| request.headers[key] = value }
      get :index
    end

    it 'result' do
      expect(response.response_code).to eq 200
      body = tasks.as_json
      expect(response.body).to match_json_expression body
      expect(response.headers['Total-Count']).to eq(tasks.size.to_s)
      expect(response.headers['Link']).not_to be_nil
    end
  end

  describe 'GET show' do
    let(:task) { create(:task, user_id: user.id) }

    before do
      params = { id: task.id }
      headers = { 'Authorization' => "Bearer #{access_token.token}" }
      headers.each { |key, value| request.headers[key] = value }
      get :show, params: params
    end

    it 'result' do
      expect(response.response_code).to eq 200
      body = task.as_json
      expect(response.body).to match_json_expression body
    end
  end

  describe 'POST create' do
    context '入力エラーなし' do
      before do
        task_params = attributes_for(:task)
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        headers.each { |key, value| request.headers[key] = value }
        post :create, params: { task: task_params }
      end

      it 'result' do
        expect(response.response_code).to eq 201
        body = Task.last.as_json
        expect(response.body).to match_json_expression body
      end
    end

    context '入力エラーあり' do
      before do
        task_params = attributes_for(:task, title: nil)
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        headers.each { |key, value| request.headers[key] = value }
        post :create, params: { task: task_params }
      end

      it 'result' do
        expect(response.response_code).to eq 400
      end
    end
  end

  describe 'PATCH update' do
    let(:task) { create(:task, user_id: user.id) }

    context '入力エラーなし' do
      let(:task_params) { attributes_for(:task) }

      before do
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        headers.each { |key, value| request.headers[key] = value }
        patch :update, params: { id: task.id, task: task_params }
      end

      it 'result' do
        expect(response.response_code).to eq 200
        body = Task.find(task.id).as_json
        expect(response.body).to match_json_expression body
      end
    end

    context '入力エラーあり' do
      let(:task_params) { attributes_for(:task, title: nil) }

      before do
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        headers.each { |key, value| request.headers[key] = value }
        patch :update, params: { id: task.id, task: task_params }
      end

      it 'result' do
        expect(response.response_code).to eq 400
      end
    end
  end
end
