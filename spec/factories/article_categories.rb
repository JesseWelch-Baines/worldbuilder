FactoryBot.define do
  factory :article_category do
    user { User.find_by(superuser: true) || association(:user) }
    name { "Character" }
  end
end
