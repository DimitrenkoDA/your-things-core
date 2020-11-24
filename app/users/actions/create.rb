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

        if inputs[:password] != inputs[:password_confirmation]
          fail!({ errors: { password: 'password and password confirmation do not match' }})
          return
        end

        if Models::User.find_by(email: inputs[:email])
          fail!({ errors: { email: 'user with such email alredy exists' }})
          return
        end

        Record.transaction do
          @user = Models::User.new

          buyer_role = Models::Role.find_or_create_by(code: 'buyer', title: 'Покупатель')

          user_role = Models::UserRole.new(role: buyer_role, user: @user)

          @user.email = inputs[:email]
          @user.password = inputs[:password]
          @user.password_confirmation = inputs[:password_confirmation]

          unless @user.save && user_role.save
            rollback!(errors: @user.errors)
          end

          success!
        end
      end

      private def authorize!
        return if current_user.operator?

        access_denied!
      end
    end
  end
end
