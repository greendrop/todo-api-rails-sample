# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:doorkeeper_application) { create_doorkeeper_application }
  let(:access_token) { create_doorkeeper_access_token(doorkeeper_application, user) }

  describe 'GET me' do
    describe 'アクセストークンあり' do
      before do
        params = { format: :json }
        headers = { 'Authorization' => "Bearer #{access_token.token}" }
        headers.each { |key, value| request.headers[key] = value }
        get :me, params: params
      end

      it 'response' do
        expect(response.response_code).to eq 200
        body = user.as_json
        expect(response.body).to match_json_expression body
      end
    end

    describe 'アクセストークンなし' do
      before do
        params = { format: :json }
        get :me, params: params
      end

      it 'response' do
        expect(response.response_code).to eq 401
      end
    end
  end
end
