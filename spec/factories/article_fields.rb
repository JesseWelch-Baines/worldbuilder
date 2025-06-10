FactoryBot.define do
  factory :article_field do
    user { Current.user || association(:user) }
    article_category { association(:article_category) }
    name { "Field Name" }
  end
end
