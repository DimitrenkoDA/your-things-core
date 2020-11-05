module Roles
  module Endpoints
    class Index < Endpoint
      authenticate!

      def handle
        authorize!
        render status: 200, body: json(Roles::Presenters::Index.new(Models::Role.all).as_json)
      end

      private def authorize!
        return if current_user.operator?

        access_denied!
      end
    end
  end
end
