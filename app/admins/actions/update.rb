module Admins
  module Actions
    class Update < Action
      schema do
        required(:admin_id) { filled? & int? }

        optional(:email) { filled? & str? }
        optional(:phone) { filled? & str? }
        optional(:first_name) { filled? & str? }
        optional(:last_name) { filled? & str? }
      end

      def execute!
        authorize!

        if inputs.has_key?(:email)
          if !email_valid?(inputs[:email])
            fail!({ errors: { email: "has invalid format" }})
            return
          end  

          admin.email = inputs[:email]
        end

        if inputs.has_key?(:phone)
          admin.phone = inputs[:phone]
        end

        if inputs.has_key?(:first_name)
          admin.first_name = inputs[:first_name]
        end

        if inputs.has_key?(:last_name)
          admin.last_name = inputs[:last_name]
        end

        unless admin.save
          fail!(errors: admin.errors)
          return
        end

        success!
      end

      def admin
        @admin ||= Models::Admin.find(inputs[:admin_id])
      end

      private

      EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

      def authorize!
        return if current_user.operator?
        return if inputs[:admin_id] == current_user.id

        access_denied!
      end

      def email_valid?(email)
        Admins::Actions::Update::EMAIL_FORMAT.match?(email)
      end
    end
  end
end
