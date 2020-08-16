# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Api::UserBaseController
        skip_before_action :doorkeeper_authorize!, only: [:create]

        def create
          user = User.new(user_params)
          if user.save
            render json: user, serializer: Api::UserSerializer, status: :created
          else
            serializer = Api::UserSerializer.new(user, with_errors: true)
            render json: serializer.serializable_hash, status: :bad_request
          end
        end

        def update
          user = current_resource_owner
          if user.update(user_params)
            head 204
          else
            render json: user.as_json.merge(errors: validate_errors(user)), status: :bad_request
          end
        end

        def destroy
          user = current_resource_owner
          user.destroy!
          head 204
        end

        private

        def user_params
          params.require(:user).permit(:email, :password)
        end
      end
    end
  end
end
