module Admins
  module Actions
    class Delete < Action
      schema do
        required(:admin_id) { filled? & int? }
      end

      def execute!
        authorize!
      
        unless admin.destroy
          fail!(errors: admin.errors)
          return
        end

        success!
      end

      def admin
        @admin ||= Models::Admin.find(inputs[:admin_id])
      end

      private

      def authorize!
        return if current_user.operator?
        return if current_user.id == inputs[:admin_id]

        access_denied!
      end
    end
  end
end
