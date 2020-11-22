module Shops
  module Actions
    class Create < Action
      schema do
        required(:user_id) { filled? & int? }
        required(:name) { filled? & str? }

        optional(:description).maybe { str? }
      end

      attr_reader :shop

      def execute!
        authorize!

        @shop = Models::Shop.create(user_id: user.id, name: name)

        if inputs.has_key?(:description)
          @shop.description = description
        end

        unless @shop.save
          rollback!(errors: @shop.errors)
        end

        success!
      end

      private

      def user
        @user ||= Models::User.find(inputs[:user_id])
      end

      def authorize!
        return if current_user.operator?
        return if current_user.seller?

        access_denied!
      end
    end
  end
end
