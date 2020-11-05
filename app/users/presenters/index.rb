module Users
  module Presenters
    class Index < Presenter
      def initialize(users)
        @users = users
      end

      def as_json
        {
          users: @users.map { |user| Users::Presenters::Show.new(user).as_json }
        }
      end
    end
  end
end
