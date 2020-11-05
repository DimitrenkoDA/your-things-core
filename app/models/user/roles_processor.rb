class User
  class RolesProcessor
    def initialize(user)
      @user = user
    end

    def roles
      return user.user_roles.preload(:role).map(&:role)
    end

    def admin?
      user.user_roles.joins(:role).where(roles: { code: 'admin' }).any?
    end

    def buyer?
      user.user_roles.joins(:role).where(roles: { code: 'buyer' }).any?
    end

    def seller?
      user.user_roles.joins(:role).where(roles: { code: 'seller' }).any?
    end

    private

    attr_reader :user
  end
end
