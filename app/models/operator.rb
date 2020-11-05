module Models
  class Operator < Record
    validates :email, presence: true, uniqueness: true

    has_secure_password

    before_validation :normalize_email

    def operator?
      true
    end

    def user?
      false
    end

    private def normalize_email
      self.email = email&.strip&.downcase
    end
  end
end
