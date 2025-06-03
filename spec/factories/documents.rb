FactoryBot.define do
  factory :document do
    user { Current.user || association(:user) }
    world { association :world }
    name { "Sample Document" }
  end
end
