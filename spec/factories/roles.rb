FactoryBot.define do
  factory :role, class: 'Models::Role' do
    trait :buyer do
      initialize_with { Models::Role.find_or_create_by(code: 'buyer', title: 'Покупатель') }
    end

    trait :seller do
      initialize_with { Models::Role.find_or_create_by(code: 'seller', title: 'Продавец') }
    end
  end
end
