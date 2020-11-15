module Models
  class Shop < Record
    scope :unreviewed, -> { where(reviewed_at: nil) }
    scope :reviewed, -> { where.not(reviewed_at: nil) }

    belongs_to :user, class_name: 'Models::User'
  end
end
