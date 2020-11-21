module Admins
  module Presenters
    class Index < Presenter
      def initialize(admins)
        @admins = admins
      end

      def as_json
        {
          admins: @admins.map { |admin| Admins::Presenters::Show.new(admin).as_json }
        }
      end
    end
  end
end
