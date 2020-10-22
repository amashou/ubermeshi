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