module Sessions
  module Owners
    class Admin < Sessions::Owners::Base
      def deserialize(payload)
        admin = Models::Admin.find_by(id: payload[:id])

        if admin.nil?
          raise Sessions::Owners::InvalidPayload, "Failed to find admin by given session"
        end

        admin
      end

      def serialize(admin)
        {
          id: admin.id
        }
      end

      def as_json(admin)
        Admins::Presenters::Show.new(admin).as_json
      end

      def authenticate(credentials)
        if credentials[:email].nil? || credentials[:password].nil?
          return
        end

        admin = Models::Admin.find_by(email: credentials[:email])

        if admin.nil?
          return
        end

        if !admin.authenticate(credentials[:password])
          return
        end

        Sessions::Session.for(Sessions::Owners::Admin::KIND, admin)
      end
    end
  end
end
