module Users
  module Presenters
    class Show < Presenter
      def initialize(user)
        @user = user
      end

      def as_json
        {
          id: @user.id,
          email: @user.email,
          first_name: @user.first_name,
          last_name: @user.last_name,
          created_at: @user.created_at,
          updated_at: @user.updated_at
        }
      end
    end
  end
end
