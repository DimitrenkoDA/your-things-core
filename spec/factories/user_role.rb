FactoryBot.define do
  factory :user_role, class: 'Models::UserRole' do
    role
    user

    trait :buyer do
      role { create(:role, :buyer) }
      activated_at { nil }
    end

    trait :seller do
      role { create(:role, :seller) }
      activated_at { 1.day.ago }
    end
  end
end
