module Shops
  module Presenters
    class Show < Presenter
      def initialize(shop)
        @shop = shop
      end

      def as_json
        {
          id: @shop.id,
          name: @shop.name,
          description: @shop.description,
          reviewed_at: @shop.reviewed_at,
          created_at: @shop.created_at,
          updated_at: @shop.updated_at
        }
      end
    end
  end
end
