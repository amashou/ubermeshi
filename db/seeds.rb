5.times do |n|
    User.create(
        email: "test#{n + 1}@test.com",
        name: "test.No#{n+1}",
        password: "password",
        password_confirmation: "password"
    )
end

User.create(
    name: "Amashou",
    email: "amano@example.com",
    password: "password",
    password_confirmation: "password"
)

5.times do |n|
    Post.create(
        title: "test#{n + 1}t==itle",
        user_id: "#{n + 1}",
        restaurant_id: 1,
        description: "test.desctiprion#{n+1}",
        restaurant_name: "password",
    )
end