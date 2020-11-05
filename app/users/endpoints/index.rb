module Users
  module Endpoints
    class Index < Endpoint
      authenticate!

      def handle
        search = Users::Search.new(args, current_user: current_user)
        users = search.perform
        render status: 200, body: json(Users::Presenters::Index.new(users).as_json)
      end

      private def args
        {}
      end
    end
  end
end
