module Models
  class UserRole < Record
    scope :inactive, -> { where(activated_at: nil) }
    scope :active, -> { where.not(activated_at: nil) }

    belongs_to :role, class_name: 'Models::Role'
    belongs_to :user, class_name: 'Models::User'

    def active?
      activated_at.present?
    end
  end
end
