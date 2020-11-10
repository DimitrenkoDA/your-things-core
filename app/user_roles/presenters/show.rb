module UserRoles
  module Presenters
    class Show < Presenter
      def initialize(user_role)
        @user_role = user_role
      end

      def as_json
        {
          id: @user_role.id,
          user: @user_role.user.slice(:id, :first_name, :last_name),
          role: @user_role.role.slice(:id, :code, :title),
          activated_at: @user_role.activated_at,
          created_at: @user_role.created_at,
          updated_at: @user_role.updated_at
        }
      end

      private

      attr_reader :role
    end
  end
end
