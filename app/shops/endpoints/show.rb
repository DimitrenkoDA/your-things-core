module Shops
  module Endpoints
    class Show < Endpoint
      authenticate!

      def handle
        search = Shops::Search.new(args, current_user: current_user)
        shop = search.one!
        render status: 200, body: json(Shops::Presenters::Show.new(shop).as_json)
      end

      private def args
        {
          shop_id: request.params[:shop_id].to_i
        }
      end
    end
  end
end
