module Admins
  module Endpoints
    class Delete < Endpoint
      authenticate!

      def handle
        action = Admins::Actions::Delete.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        {
          admin_id: request.params[:admin_id].to_i
        }
      end
    end
  end
end
