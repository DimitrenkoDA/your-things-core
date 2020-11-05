module Users
  module Actions
    class Delete < Action
      schema do
        required(:user_id) { filled? & int? }
      end

      attr_reader :user

      def execute!
        @user = search.one!

        unless @user.destroy
          fail!(errors: @user.errors)
          return
        end

        success!
      end

      private def search
        @search ||= Users::Search.new({ user_id: user_id }, current_user: current_user)
      end
    end
  end
end
