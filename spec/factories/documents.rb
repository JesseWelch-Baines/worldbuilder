FactoryBot.define do
  factory :document do
    user { User.find_by(superuser: true) || association(:user) }
    world { association :world }
    name { "Sample Document" }
  end
end
