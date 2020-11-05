module Users
  module Endpoints
    class Update < Endpoint
      authenticate!

      def handle
        action = Users::Actions::Update.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200, body: json(Users::Presenters::Show.new(action.user).as_json)
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        args = {
          user_id: request.params[:user_id].to_i,
        }

        if request.json.has_key?(:email)
          args[:email] = request.json[:email]
        end

        if request.json.has_key?(:first_name)
          args[:first_name] = request.json[:first_name]
        end

        if request.json.has_key?(:last_name)
          args[:last_name] = request.json[:last_name]
        end

        args
      end
    end
  end
end
