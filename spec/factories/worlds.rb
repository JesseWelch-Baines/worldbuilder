FactoryBot.define do
  factory :world do
    user { Current.user || association(:user) }
    name { "Sample World" }
  end
end
