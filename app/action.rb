class Action < Performify::Base
  class AccessDenied < StandardError; end

  def self.anonymous!
    self.define_method :initialize do |args = {}|
      super(nil, args)
    end
  end

  protected def access_denied!
    raise Action::AccessDenied
  end
end
