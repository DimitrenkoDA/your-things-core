module Users
  module Actions
    class Update < Action
      schema do
        required(:user_id) { filled? & int? }

        optional(:email) { filled? & str?}
        optional(:first_name) { filled? & str?}
        optional(:last_name) { filled? & str?}
      end

      def execute!
        authorize!

        if inputs.has_key?(:email)
          user.email = inputs[:email]
        end

        if inputs.has_key?(:first_name)
          user.first_name = inputs[:first_name]
        end

        if inputs.has_key?(:last_name)
          user.last_name = inputs[:last_name]
        end

        unless user.save
          fail!(errors: user.errors)
          return
        end

        success!
      end

      def user
        @user ||= Models::User.find(inputs[:user_id])
      end

      private

      def authorize!
        return if current_user.operator?
        return if inputs[:user_id] == current_user.id

        access_denied!
      end
    end
  end
end
