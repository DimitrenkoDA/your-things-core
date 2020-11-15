module Shops
  module Presenters
    class Index < Presenter
      def initialize(shops)
        @shops = shops
      end

      def as_json
        {
          shops: @shops.map { |shop| Shops::Presenters::Show.new(shop).as_json }
        }
      end
    end
  end
end
