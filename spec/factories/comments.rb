FactoryBot.define do

  factory :comment do
    association :post, factory: :post
    association :user, factory: :user_n
    content         { "test_comment" }
  end

  trait :with_replys do
    transient do
      replys_count { 5 }
    end

    after(:create) do | comment, evaluator |
      create_list(:reply, evaluator.replys_count, comment: comment)
    end

  end
end
