module Admins
  module Endpoints
    class Index < Endpoint
      authenticate!

      def handle
        search = Admins::Search.new(args, current_user: current_user)
        admins = search.perform
        render status: 200, body: json(Admins::Presenters::Index.new(admins).as_json)
      end

      private def args
        {}
      end
    end
  end
end
