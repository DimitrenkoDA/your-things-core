module Users
  module Actions
    class Create < Action
      schema do
        required(:email) { filled? & str? }
        required(:password) { filled? & str? }
        required(:password_confirmation) { filled? & str? }
      end

      attr_reader :user

      def execute!
        authorize!

        @user = Models::User.new

        if inputs[:password] != inputs[:password_confirmation]
          fail!({ errors: { password: 'password and password confirmation do not match' }})
          return
        end

        @user.email = inputs[:email]
        @user.password = inputs[:password]
        @user.password_confirmation = inputs[:password_confirmation]

        unless @user.save
          rollback!(errors: @user.errors)
        end

        success!
      end

      private def authorize!
        return if current_user.operator?

        access_denied!
      end
    end
  end
end
