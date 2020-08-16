# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Users::RegistrationsController, type: :request do
  let(:auth_user) { create(:user) }
  let(:doorkeeper_application) { create_doorkeeper_application }
  let(:access_token) { create_doorkeeper_access_token(doorkeeper_application, auth_user) }

  describe 'POST api_v1_users_registration_url' do
    context '入力エラーなし' do
      let(:user_params) { { email: 'user1@example.com', password: 'password' } }

      before do
        post api_v1_users_registration_url, params: { user: user_params }
      end

      it '登録できること' do
        expect(response.status).to eq 201

        body = JSON.parse(response.body)
        user = User.last
        expect(body['id']).to eq(user.id)
        expect(body['email']).to eq(user.email)
        expect(body['created_at']).to eq(user.created_at.strftime('%FT%T.%L%:z'))
        expect(body['updated_at']).to eq(user.updated_at.strftime('%FT%T.%L%:z'))
      end
    end

    context '入力エラーあり' do
      let(:user_params) { { email: '', password: 'password' } }

      before do
        post api_v1_users_registration_url, params: { user: user_params }
      end

      it '登録できないこと' do
        expect(response.status).to eq 400

        body = JSON.parse(response.body)
        expect(body['errors'].present?).to be_truthy
      end
    end
  end

  describe 'PATCH api_v1_users_registration_url' do
    describe '認証あり' do
      context '入力エラーなし' do
        let(:user_params) { { email: 'user1update@example.com' } }

        before do
          headers = { 'Authorization' => "Bearer #{access_token.token}" }
          patch api_v1_users_registration_url, params: { user: user_params }, headers: headers
        end

        it '更新できること' do
          expect(response.status).to eq 204
        end
      end

      context '入力エラーあり' do
        let(:user_params) { { email: '' } }

        before do
          headers = { 'Authorization' => "Bearer #{access_token.token}" }
          patch api_v1_users_registration_url, params: { user: user_params }, headers: headers
        end

        it '更新できないこと' do
          expect(response.status).to eq 400
        end
      end
    end

    describe '認証なし' do
      before do
        patch api_v1_users_registration_url
      end

      it 'エラーコードが取得できること' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'DELETE api_v1_users_registration_url' do
    describe '認証あり' do
      before do
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        delete api_v1_users_registration_url, headers: headers
      end

      it '削除できること' do
        expect(response.status).to eq 204
        expect(User.find_by(id: auth_user.id)).to be_nil
      end
    end

    describe '認証なし' do
      before do
        delete api_v1_users_registration_url
      end

      it 'エラーコードが取得できること' do
        expect(response.status).to eq(401)
      end
    end
  end
end
