# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::UserBaseController
      # サインインユーザを出力する
      def me
        render json: current_resource_owner, serializer: Api::UserSerializer
      end
    end
  end
end
