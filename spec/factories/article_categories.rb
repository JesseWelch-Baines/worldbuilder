FactoryBot.define do
  factory :article_category do
    user { Current.user || association(:user) }
    name { "Character" }
  end
end
