FactoryBot.define do
  factory :admin, class: 'Models::Admin' do
    email { FFaker::Internet.email }
    phone { FFaker::PhoneNumberRU.phone_number }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    password { SecureRandom.hex(8) }
    password_confirmation { password }
  end
end
