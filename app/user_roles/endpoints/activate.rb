module UserRoles
  module Endpoints
    class Activate < Endpoint
      authenticate!

      def handle
        action = UserRoles::Actions::Activate.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200, body: json(UserRoles::Presenters::Show.new(action.user_role).as_json)
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        {
          user_id: request.params[:user_id].to_i,
          user_role_id: request.params[:user_role_id].to_i
        }
      end
    end
  end
end
