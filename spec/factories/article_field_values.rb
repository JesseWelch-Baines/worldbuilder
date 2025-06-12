FactoryBot.define do
  factory :article_field_value do
    user { User.find_by(superuser: true) || association(:user) }
    article { association(:article) }
    article_field { association(:article_field) }
    value { "Sample Value" }
  end
end
