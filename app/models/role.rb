module Models
  class Role < Record
    has_many :user_roles, class_name: 'Models::UserRole', dependent: :restrict_with_error
    has_many :users, class_name: 'Models::User', through: :user_roles

    validates :code, presence: true

    enum code: {
      admin: 'admin',
      buyer: 'buyer',
      seller: 'seller'
    }
  end
end
