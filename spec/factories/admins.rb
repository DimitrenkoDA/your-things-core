FactoryBot.define do
  factory :admin, class: 'Models::Admin' do
    email { FFaker::Internet.email }
    password { SecureRandom.hex(8) }
    password_confirmation { password }
  end
end
