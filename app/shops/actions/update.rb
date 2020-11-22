module Shops
  module Actions
    class Update < Action
      schema do
        required(:shop_id) { filled? & int? }

        optional(:name) { filled? & str? }
        optional(:description) { filled? & str? }
      end

      def execute!
        authorize!

        if inputs.has_key?(:name)
          shop.name = inputs[:name]
        end

        if inputs.has_key?(:description)
          shop.description = inputs[:description]
        end

        unless shop.save
          fail!(errors: shop.errors)
          return
        end

        success!
      end

      def shop
        @shop ||= Models::Shop.find(inputs[:shop_id])
      end

      private
      
      def authorize!
        return if current_user.operator?
        return if current_user.seller? && current_user.id == shop.user_id

        access_denied!
      end
    end
  end
end
