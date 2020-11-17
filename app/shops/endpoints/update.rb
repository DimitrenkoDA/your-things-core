module Shops
  module Endpoints
    class Update < Endpoint
      authenticate!

      def handle
        action = Shops::Actions::Update.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200, body: json(Shops::Presenters::Show.new(action.shop).as_json)
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        args = {
          shop_id: request.params[:shop_id].to_i,
        }

        if request.json.has_key?(:name) 
          args[:name] = request.json[:name]
        end

        if request.json.has_key?(:description) 
          args[:description] = request.json[:description]
        end
        
        args
      end
    end
  end
end
