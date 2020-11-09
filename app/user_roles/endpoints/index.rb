module UserRoles
  module Endpoints
    class Index < Endpoint
      authenticate!

      def handle
        search = UserRoles::Search.new(args, current_user: current_user)
        user_roles = search.perform
        render status: 200, body: json(UserRoles::Presenters::Index.new(user_roles).as_json)
      end

      private def args
        {
          user_id: request.params[:user_id].to_i
        }
      end
    end
  end
end
