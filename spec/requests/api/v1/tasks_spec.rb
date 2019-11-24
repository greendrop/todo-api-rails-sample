# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  let(:user) { create(:user) }
  let(:doorkeeper_application) { create_doorkeeper_application }
  let(:access_token) { create_doorkeeper_access_token(doorkeeper_application, user) }

  describe 'GET api_v1_tasks_url' do
    let!(:tasks) { create_list(:task, 3, user_id: user.id) }

    describe '認証あり' do
      before do
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        get api_v1_tasks_url, headers: headers
      end

      it '正常に取得できること' do
        expect(response.status).to eq(200)

        body = tasks.as_json
        expect(response.body).to match_json_expression body
        expect(response.headers['Total-Count']).to eq(tasks.size.to_s)
        expect(response.headers['Link']).not_to be_nil
      end
    end

    describe '認証なし' do
      before do
        get api_v1_tasks_url
      end

      it 'エラーコードが取得できること' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'GET api_v1_task_url' do
    let(:task) { create(:task, user: user) }

    describe '認証あり' do
      before do
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        get api_v1_task_url(id: task.id), headers: headers
      end

      it '正常に取得できること' do
        expect(response.status).to eq(200)

        body = JSON.parse(response.body)
        expect(body['id']).to eq(task.id)
        expect(body['title']).to eq(task.title)
        expect(body['description']).to eq(task.description)
        expect(body['done']).to eq(task.done)
        expect(body['created_at']).to eq(task.created_at.strftime('%FT%T.%L%:z'))
        expect(body['updated_at']).to eq(task.updated_at.strftime('%FT%T.%L%:z'))
      end
    end

    describe '認証なし' do
      before do
        get api_v1_task_url(id: task.id)
      end

      it 'エラーコードが取得できること' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST api_v1_tasks_url' do
    describe '認証あり' do
      context '入力エラーなし' do
        let(:task_params) { attributes_for(:task) }

        before do
          headers = { 'Authorization' => "Bearer #{access_token.token}" }
          post api_v1_tasks_url, params: { task: task_params }, headers: headers
        end

        it '登録できること' do
          expect(response.status).to eq 201

          body = JSON.parse(response.body)
          task = Task.last
          expect(body['id']).to eq(task.id)
          expect(body['title']).to eq(task.title)
          expect(body['description']).to eq(task.description)
          expect(body['done']).to eq(task.done)
          expect(body['created_at']).to eq(task.created_at.strftime('%FT%T.%L%:z'))
          expect(body['updated_at']).to eq(task.updated_at.strftime('%FT%T.%L%:z'))
        end
      end

      context '入力エラーあり' do
        let(:task_params) { attributes_for(:task, title: '') }

        before do
          headers = { 'Authorization' => "Bearer #{access_token.token}" }
          post api_v1_tasks_url, params: { task: task_params }, headers: headers
        end

        it '登録できないこと' do
          expect(response.status).to eq 400

          body = JSON.parse(response.body)
          expect(body['errors'].present?).to be_truthy
        end
      end
    end

    describe '認証なし' do
      before do
        post api_v1_tasks_url
      end

      it 'エラーコードが取得できること' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'PATCH api_v1_task_url' do
    let(:task) { create(:task, user: user) }

    describe '認証あり' do
      context '入力エラーなし' do
        let(:task_params) { attributes_for(:task, title: 'update') }

        before do
          headers = { 'Authorization' => "Bearer #{access_token.token}" }
          patch api_v1_task_url(id: task.id), params: { task: task_params }, headers: headers
        end

        it '更新できること' do
          expect(response.status).to eq 204
        end
      end

      context '入力エラーあり' do
        let(:task_params) { attributes_for(:task, title: '') }

        before do
          headers = { 'Authorization' => "Bearer #{access_token.token}" }
          patch api_v1_task_url(id: task.id), params: { task: task_params }, headers: headers
        end

        it '更新できないこと' do
          expect(response.status).to eq 400
        end
      end
    end

    describe '認証なし' do
      before do
        patch api_v1_task_url(id: task.id)
      end

      it 'エラーコードが取得できること' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'PATCH api_v1_task_url' do
    let(:task) { create(:task, user: user) }

    describe '認証あり' do
      before do
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        delete api_v1_task_url(id: task.id), headers: headers
      end

      it '削除できること' do
        expect(response.status).to eq 204
        expect(Task.find_by(id: task.id)).to be_nil
      end
    end

    describe '認証なし' do
      before do
        delete api_v1_task_url(id: task.id)
      end

      it 'エラーコードが取得できること' do
        expect(response.status).to eq(401)
      end
    end
  end
end
