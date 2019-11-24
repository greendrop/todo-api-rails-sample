# frozen_string_literal: true

module Auth
  module Users
    class RegistrationsController < Devise::RegistrationsController
      layout 'auth'

      before_action :set_head_title
      before_action :configure_sign_up_params, only: [:create]
      before_action :configure_account_update_params, only: [:update]

      def auth_user_root_path
        root_path
      end

      private

      def set_head_title
        @head_title =
          if %w[new create].include?(action_name)
            t('auth.users.registrations.new.title')
          elsif %w[edit update].include?(action_name)
            t('auth.users.registrations.edit.title')
          end
      end

      def devise_mapping
        Devise.mappings[:user]
      end

      protected

      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [])
      end

      def configure_account_update_params
        devise_parameter_sanitizer.permit(:account_update, keys: [])
      end
    end
  end
end
