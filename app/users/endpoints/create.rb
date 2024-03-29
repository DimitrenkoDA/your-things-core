module Users
  module Endpoints
    class Create < Endpoint
      authenticate!

      def handle
        action = Users::Actions::Create.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200, body: json(Users::Presenters::Show.new(action.user).as_json)
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
