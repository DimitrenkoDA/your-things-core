module UserRoles
  module Presenters
    class Index < Presenter
      def initialize(user_roles)
        @user_roles  = user_roles
      end

      def as_json
        {
          user_roles: @user_roles.map { |user_role| UserRoles::Presenters::Show.new(user_role).as_json }
        }
      end
    end
  end
end
