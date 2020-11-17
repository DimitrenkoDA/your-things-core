module Shops
  module Endpoints
    class Create < Endpoint
      authenticate!

      def handle
        action = Shops::Actions::Create.new(current_user, args)
        action.execute!
        
        if action.success?
          render status: 200, body: json(Shops::Presenters::Show.new(action.shop).as_json)
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        {
          user_id: request.json[:user_id].to_i,
          name: request.json[:name],
          description: request.json[:description],
        }
      end
    end
  end
end
