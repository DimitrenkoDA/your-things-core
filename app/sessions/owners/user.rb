module Sessions
  module Owners
    class User < Sessions::Owners::Base
      def deserialize(payload)
        user = Models::User.find_by(id: payload[:id])

        if user.nil?
          raise Sessions::Owners::InvalidPayload, "Failed to find user for given session"
        end

        user
      end

      def serialize(user)
        {
          id: user.id
        }
      end

      def as_json(user)
        Users::Presenters::Show.new(user).as_json
      end

      def authenticate(credentials)
        if credentials[:email].nil? || credentials[:password].nil?
          return
        end

        user = Models::User.find_by(email: credentials[:email])

        if user.nil?
          return
        end

        if !user.authenticate(credentials[:password])
          return
        end

        Sessions::Session.for(Sessions::Owners::User::KIND, user)
      end
    end
  end
end
