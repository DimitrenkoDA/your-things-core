module Users
  module Endpoints
    class SignUp < Endpoint
      def handle
        action = Users::Actions::SignUp.new(args)
        action.execute!

        if action.success?
          render status: 200
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        {
          email: request.json[:email]
        }
      end
    end
  end
end
