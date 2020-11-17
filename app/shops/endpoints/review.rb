module Shops
  module Endpoints
    class Review < Endpoint
      authenticate!

      def handle
        action = Shops::Actions::Review.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200, body: json(Shops::Presenters::Show.new(action.shop).as_json)
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        {
          shop_id: request.params[:shop_id].to_i
        }
      end
    end
  end
end
