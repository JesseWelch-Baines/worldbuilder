FactoryBot.define do
  factory :world do
    user { User.find_by(superuser: true) || association(:user) }
    name { "Sample World" }
  end
end
