module Admins
  module Actions
    class Create < Action
      schema do
        required(:email) { filled? & str? }
        required(:password) { filled? & str? }
        required(:password_confirmation) { filled? & str? }
      end

      attr_reader :admin

      def execute!
        authorize!

        if inputs[:password] != inputs[:password_confirmation]
          fail!({ errors: { password: 'password and password confirmation do not match' }})
          return
        end
        
        if Models::Admin.find_by(email: inputs[:email])
          fail!({ errors: { email: 'admin with such email alredy exists' }})
          return
        end

        @admin = Models::Admin.new

        @admin.email = inputs[:email]
        @admin.password = inputs[:password]
        @admin.password_confirmation = inputs[:password_confirmation]

        unless @admin.save
          rollback!(errors: @admin.errors)
        end

        success!
      end

      private

      def authorize!
        return if current_user.operator?
        access_denied!
      end
    end
  end
end
