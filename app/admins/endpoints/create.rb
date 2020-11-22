module Admins
  module Endpoints
    class Create < Endpoint
      authenticate!

      def handle
        action = Admins::Actions::Create.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200, body: json(Admins::Presenters::Show.new(action.admin).as_json)
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        {
          email: request.json[:email],
          password: request.json[:password],
          password_confirmation: request.json[:password_confirmation]
        }
      end
    end
  end
end
