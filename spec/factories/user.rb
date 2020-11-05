FactoryBot.define do
  factory :user, class: 'Models::User' do
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    password { SecureRandom.hex(8) }
    password_confirmation { password }

    factory(:admin) do
      after(:create) do |admin|
        create(:user_role, :admin, user: admin)
      end
    end

    factory(:buyer) do
      after(:create) do |buyer|
        create(:user_role, :buyer, user: buyer)
      end
    end

    factory(:seller) do
      after(:create) do |seller|
        create(:user_role, :seller, user: seller)
      end
    end
  end
end
