module Users
  module Actions
    class Create < Action
      schema do
        required(:email) { filled? & str? }
        required(:first_name) { filled? & str? }
        required(:last_name) { filled? & str? }
      end

      attr_reader :user

      def execute!
        authorize!

        Record.transaction do
          @user = Models::User.new

          @user.email = inputs[:email]
          @user.first_name = inputs[:first_name]
          @user.last_name = inputs[:last_name]

          @user.password = generated_password
          @user.password_confirmation = generated_password

          unless @user.save
            rollback!(errors: @user.errors)
          end

          success!
        end
      end

      private def authorize!
        return if current_user.operator?
        access_denied!
      end

      private def generated_password
        @generated_password ||= SecureRandom.hex(16)
      end
    end
  end
end
