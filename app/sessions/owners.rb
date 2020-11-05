module Sessions
  module Owners
    class InvalidPayload < StandardError; end
    class InvalidKind < StandardError; end

    def self.for(kind)
      case kind
      when Sessions::Owners::Operator::KIND
        Sessions::Owners::Operator.new
      when Sessions::Owners::User::KIND
        Sessions::Owners::User.new
      else
        raise InvalidKind, "Invalid session kind: #{kind}"
      end
    end
  end
end
