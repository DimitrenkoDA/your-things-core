module Admins
  module Endpoints
    class Show < Endpoint
      authenticate!

      def handle
        search = Admins::Search.new(args, current_user: current_user)
        admin = search.one!
        render status: 200, body: json(Admins::Presenters::Show.new(admin).as_json)
      end

      private def args
        {
          admin_id: request.params[:admin_id].to_i
        }
      end
    end
  end
end
