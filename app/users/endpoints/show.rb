module Users
  module Endpoints
    class Show < Endpoint
      authenticate!

      def handle
        search = Users::Search.new(args, current_user: current_user)
        user = search.one!
        render status: 200, body: json(Users::Presenters::Show.new(user).as_json)
      end

      private def args
        {
          user_id: request.params[:user_id].to_i
        }
      end
    end
  end
end
