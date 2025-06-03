FactoryBot.define do
  factory :article do
    user { Current.user || association(:user) }
    world { association :world }
    category { association :article_category }
    name { "Sample Article" }
  end
end
