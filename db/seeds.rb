5.times do |n|
    User.create(
        email: "test#{n + 1}@test.com",
        name: "test.No#{n+1}",
        password: "password",
        password_confirmation: "password"
    )
end
Restaurant.create(
    name: "test_restaurant_name"
)
5.times do |n|
    Post.create(
        title: "test#{n + 1}==title",
        user_id: "#{n + 1}",
        restaurant_id: 1,
        description: "test.desctiprion#{n+1}",
        restaurant_name: "restaurant_test_name restaurant_test_name",
        restaurant_address: "restaurant_test_address restaurant_test_address restaurant_test_address"
    )
end

User.create(
    name: "Amashou",
    email: "amano@example.com",
    password: "password",
    password_confirmation: "password"
)