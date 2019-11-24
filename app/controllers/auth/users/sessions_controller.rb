# frozen_string_literal: true

module Auth
  module Users
    class SessionsController < Devise::SessionsController
      layout 'auth'

      before_action :set_head_title

      def auth_user_root_path
        root_path
      end

      def after_sign_out_path_for(_resource_or_scope)
        root_path
      end

      private

      def set_head_title
        @head_title =
          if %w[new create].include?(action_name)
            t('auth.users.sessions.new.title')
          elsif %w[edit update].include?(action_name)
            t('auth.users.sessions.edit.title')
          end
      end
    end
  end
end
