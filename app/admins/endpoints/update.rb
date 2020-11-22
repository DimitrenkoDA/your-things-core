module Admins
  module Endpoints
    class Update < Endpoint
      authenticate!

      def handle
        action = Admins::Actions::Update.new(current_user, args)
        action.execute!

        if action.success?
          render status: 200, body: json(Admins::Presenters::Show.new(action.admin).as_json)
        else
          render status: 422, body: json(Errors.new(action.errors).as_json)
        end
      end

      private def args
        args = {
          admin_id: request.params[:admin_id].to_i,
        }

        if request.json.has_key?(:email)
          args[:email] = request.json[:email]
        end

        if request.json.has_key?(:phone)
          args[:phone] = request.json[:phone]
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
