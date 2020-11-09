module UserRoles
  module Endpoints
    class Show < Endpoint
      authenticate!

      def handle
        search = UserRoles::Search.new(args, current_user: current_user)
        user_role = search.one!
        render status: 200, body: json(UserRoles::Presenters::Show.new(user_role).as_json)
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
