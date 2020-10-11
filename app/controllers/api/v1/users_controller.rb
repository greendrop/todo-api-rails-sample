# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::UserBaseController
      # サインインユーザを出力する
      def me
        serializer = Api::UserSerializer.new(current_resource_owner)
        render_success serializer.serializable_hash
      end
    end
  end
end
