FactoryBot.define do
  factory :article_category do
    user { association :user }
    name { "Character" }
  end
end
