module Users
  module Actions
    class Seller < Action
      schema do
        required(:user_id) { filled? & int? }
      end

      attr_reader :user_role

      def execute!
        authorize!

        role = Models::Role.find_by(code: 'seller')
        @user_role = Models::UserRole.find_by(user_id: user_id, role_id: role.id)

        if @user_role.nil?

          @user_role = Models::UserRole.new(role: role, user_id: user_id)

          unless @user_role.save
            fail!(errors: @user_role.errors)
            return
          end
        end

        success!
      end

      private

      def authorize!
        return if current_user.operator?
        return if current_user.id == inputs[:user_id]

        access_denied!
      end
    end
  end
end
