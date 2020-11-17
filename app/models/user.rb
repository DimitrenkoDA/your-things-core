module Models
  class User < Record
    has_many :user_roles, class_name: 'Models::UserRole', dependent: :destroy
    has_many :roles, class_name: 'Models::Role', through: :user_roles

    has_one :shop, class_name: 'Models::Shop'

    validates :email, presence: true, uniqueness: true

    has_secure_password

    before_validation :normalize_email

    def operator?
      false
    end

    def user?
      true
    end

    def roles
      return self.user_roles.preload(:role).map(&:role)
    end

    def admin?
      self.user_roles.joins(:role).where(roles: { code: 'admin' }).any?
    end

    def buyer?
      self.user_roles.joins(:role).where(roles: { code: 'buyer' }).any?
    end

    def seller?
      self.user_roles.active.joins(:role).where(roles: { code: 'seller' }).any?
    end

    private

    def normalize_email
      self.email = email&.strip&.downcase
    end
  end
end
