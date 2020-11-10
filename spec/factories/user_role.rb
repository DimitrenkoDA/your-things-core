FactoryBot.define do
  factory :user_role, class: 'Models::UserRole' do
    role
    user

    trait :admin do
      role { create(:role, :admin) }
      activated_at { nil }
    end

    trait :buyer do
      role { create(:role, :buyer) }
      activated_at { nil }
    end

    trait :seller do
      role { create(:role, :seller) }
      activated_at { nil }
    end
  end
end