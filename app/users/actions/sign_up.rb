module Users
  module Actions
    class SignUp < Action
      anonymous!

      schema do
        required(:email) { filled? & str? }
        required(:password) { filled? & str? }
        required(:password_confirmation) { filled? & str? }
      end

      attr_reader :user

      def execute!
        email = inputs[:email].to_s
        password = inputs[:password].to_s
        password_confirmation = inputs[:password_confirmation].to_s

        if !valid?(email)
          fail!({ errors: { email: "has invalid format" }})
          return
        end

        if password != password_confirmation
          fail!({ errors: { password: "password and password confirmation do not match" }})
          return
        end

        @user = Models::User.find_by(email: email)

        if @user.nil?
          buyer_role = Models::Role.find_or_create_by(code: 'buyer', title: 'Покупатель')

          @user = Models::User.new(email: email.to_s)

          user_role = Models::UserRole.new(role: buyer_role, user: @user)

          @user.password = password
          @user.password_confirmation = password

          unless @user.save && user_role.save
            fail!(errors: @user.errors)
            return
          end
        end

        success!
      end

      private

      FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

      def valid?(email)
        Users::Actions::SignUp::FORMAT.match?(email)
      end
    end
  end
end
