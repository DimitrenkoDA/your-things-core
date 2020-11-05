module Roles
  module Presenters
    class Index < Presenter
      def initialize(roles)
        @roles  = roles
      end

      def as_json
        {
          roles: @roles.map { |role| Roles::Presenters::Show.new(role).as_json }
        }
      end
    end
  end
end
