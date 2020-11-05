module Models
  class Project < Record
    has_many :user_roles, class_name: 'Models::UserRole'
    has_many :users, class_name: 'Models::User', through: :user_roles

    validates :code, presence: true, uniq: true

    enum code: {
      admin: 'admin',
      buyer: 'buyer',
      seller: 'seller'
    }
  end
end
