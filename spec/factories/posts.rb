FactoryBot.define do

  factory :post do
    association :user, factory: :user
    association :restaurant, factory: :restaurant
    title         { "test_title" }
    description   { "test_description" }
    food_picture  { "food_picture" }
    restaurant_name { "test_restaurant" }
  end

  trait :with_comments do
    transient do
      comments_count { 5 }  
    end

    after(:create) do | post, evaluator |
      create_list(:comment, evaluator.comments_count, post: post )
    end

  end

end
