module Shops
  module Endpoints
    class Index < Endpoint
      authenticate!

      def handle
        search = Shops::Search.new(args, current_user: current_user)
        shops = search.perform
        render status: 200, body: json(Shops::Presenters::Index.new(shops).as_json)
      end

      private def args
        {}
      end
    end
  end
end
