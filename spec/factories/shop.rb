FactoryBot.define do
  factory :shop, class: 'Models::Shop' do
    user
    name { FFaker::Company.name }
    description { FFaker::Lorem.paragraph }

    trait :reviewed do
      reviewed_at { 1.day.ago }
    end

    trait :unreviewed do
      reviewed_at { nil }
    end
  end
end
