FactoryBot.define do
  factory :user do
    email { "test@test.test" }
    password { "password" }
    superuser { false }
  end
end
