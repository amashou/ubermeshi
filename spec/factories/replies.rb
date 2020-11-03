FactoryBot.define do
  factory :reply do
    association :comment, factory: :comment
    association :user, factory: :user_n
    content           { "test_reply" }
  end
end
