module Shops
  module Actions
    class Delete < Action
      schema do
        required(:shop_id) { filled? & int? }
      end

      def execute!
        authorize!

        unless shop.destroy
          fail!(errors: shop.errors)
          return
        end

        success!
      end

      private
      
      def shop
        @shop ||= Models::Shop.find(inputs[:shop_id])
      end

      def authorize!
        return if current_user.operator?
        return if current_user.seller? && current_user.id == shop.user_id

        access_denied!
      end
    end
  end
end
