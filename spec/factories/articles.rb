FactoryBot.define do
  factory :article do
    user { User.find_by(superuser: true) || association(:user) }
    world { association :world }
    category { association :article_category }
    name { "Sample Article" }
  end
end
