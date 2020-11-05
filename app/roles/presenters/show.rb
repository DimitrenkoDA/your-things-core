module Roles
  module Presenters
    class Show < Presenter
      def initialize(role)
        @role = role
      end

      def as_json
        {
          id: role.id,
          code: role.code,
          title: role.title
        }
      end

      private

      attr_reader :role
    end
  end
end
