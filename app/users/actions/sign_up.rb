module Users
  module Actions
    class SignUp < Action
      anonymous!

      schema do
        required(:email) { filled? & str? }
      end

      attr_reader :user

      def execute!
        email = inputs[:email].to_s

        if !valid?(email)
          fail!({ errors: { email: "has invalid format" }})
          return
        end

        @user = Models::User.find_by(email: email)

        if @user.nil?
          buyer_role = Models::Role.find_by(code: 'buyer')

          @user = Models::User.new(email: email.to_s)

          user_role = Models::UserRole.new(role: buyer_role, user: @user)

          @user.password = random_password
          @user.password_confirmation = random_password

          unless @user.save && user_role.save
            fail!(errors: @user.errors)
            return
          end
        end

        success!
      end

      private

      FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

      def random_password
        @random_password ||= SecureRandom.hex(16)
      end

      def valid?(email)
        Users::Actions::SignUp::FORMAT.match?(email)
      end
    end
  end
end
