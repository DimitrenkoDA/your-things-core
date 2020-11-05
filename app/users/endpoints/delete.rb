module Users
  module Endpoints
    class Delete < Endpoint
      authenticate!

      def handle
        action = Users::Actions::Delete.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        {
          user_id: request.params[:user_id].to_i
        }
      end
    end
  end
end
