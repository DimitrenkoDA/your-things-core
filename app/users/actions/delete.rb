module Users
  module Actions
    class Delete < Action
      schema do
        required(:user_id) { filled? & int? }
      end

      def execute!
        authorize!

        unless user.destroy
          fail!(errors: user.errors)
          return
        end

        success!
      end

      private

      def user
        @user ||= Models::User.find(inputs[:user_id])
      end

      def authorize!
        return if current_user.operator?
        return if current_user.id == inputs[:user_id]

        access_denied!
      end
    end
  end
end
