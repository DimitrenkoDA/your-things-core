FactoryBot.define do
  factory :user_role, class: Models::UserRole do
    role
    user

    trait :admin do
      role { create(:role, :admin) }
    end

    trait :buyer do
      role { create(:role, :buyer) }
    end

    trait :seller do
      role { create(:role, :seller) }
    end
  end
end