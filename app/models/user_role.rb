module Models
  class UserRole < Record
    belongs_to :role, class_name: 'Models::Role'
    belongs_to :user, class_name: 'Models::User'
  end
end
