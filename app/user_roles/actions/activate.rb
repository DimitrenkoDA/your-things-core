module UserRoles
  module Actions
    class Activate < Action
      schema do
        required(:user_id) { filled? & int? }
        required(:user_role_id) { filled? & int? }
      end

      def execute!
        authorize!

        user_role.activated_at = Time.now.utc

        unless user_role.save
          fail!(errors: user_role.errors)
          return
        end

        success!
      end

      def user_role
        @user_role ||= user.user_roles.inactive.find(inputs[:user_role_id])
      end

      def user
        @user_role ||= Models::User.find(inputs[:user_id])
      end

      private 
      
      def authorize!
        return if current_user.operator?
        return if current_user.admin?

        access_denied!
      end
    end
  end
end
