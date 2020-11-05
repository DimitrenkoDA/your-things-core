module Models
  class User < Record
    has_many :user_roles, class_name: 'Models::UserRole'
    has_many :roles, class_name: 'Models::Role', through: :user_roles

    validates :email, presence: true, uniqueness: true

    has_secure_password

    before_validation :normalize_email

    delegate :roles, :admin?, :buyer?, :seller?, to: :roles_processor

    def operator?
      false
    end

    def user?
      true
    end

    private

    def normalize_email
      self.email = email&.strip&.downcase
    end

    def roles_processor
      @roles_processor ||= RolesProcessor.new(self)
    end
  end
end
