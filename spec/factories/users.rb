FactoryBot.define do
  factory :user do
    name                   { "test_user" }
    email                  { "test@example.com" }
    password               { "password" }
    password_confirmation  { "password" }
  end

  factory :user_n, class: User do
    name                   { "user_n" }
    sequence(:email)       { |n| "test#{n}@example.com" }
    password               { "password" }
    password_confirmation  { "password" }
  end

end
