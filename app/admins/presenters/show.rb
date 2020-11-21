module Admins
  module Presenters
    class Show < Presenter
      def initialize(admin)
        @admin = admin
      end

      def as_json
        {
          id: @admin.id,
          email: @admin.email,
          created_at: @admin.created_at.utc.iso8601,
          updated_at: @admin.updated_at.utc.iso8601
        }
      end
    end
  end
end
