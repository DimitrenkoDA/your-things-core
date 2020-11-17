module Shops
  module Actions
    class Review < Action
      schema do
        required(:shop_id) { filled? & int? }
      end

      def execute!
        authorize!

        if shop.reviewed?
          fail!(errors: { shop_id: "alredy reviewed" })
          return
        end

        shop.reviewed_at = Time.now.utc

        unless shop.save
          fail!(errors: shop.errors)
          return
        end

        success!
      end

      def shop
        @shop ||= Models::Shop.find(inputs[:shop_id])
      end

      private def authorize!
        return if current_user.operator?
        return if current_user.admin?

        access_denied!
      end
    end
  end
end
