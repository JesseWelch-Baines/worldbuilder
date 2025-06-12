FactoryBot.define do
  factory :article_field do
    user { User.find_by(superuser: true) || association(:user) }
    article_category { association(:article_category) }
    name { "Field Name" }
  end
end
