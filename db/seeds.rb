5.times do |n|
    User.create(
        email: "test#{n + 1}@test.com",
        name: "test.No#{n+1}",
        password: "password",
        password_confirmation: "password"
    )
end
Restaurant.create(
    name: "渋谷レストラン",
    address: "東京都渋谷区1-1-1",
    tel: '03-1234-5678',
    opentime: "平日12:00~21:00, 土日祭日10:00~21:00",
)
Restaurant.create(
    name: "新宿レストラン",
    address: "東京都新宿区1-1-1",
    tel: '03-1234-5678',
    opentime: "平日12:00~21:00, 土日祭日10:00~21:00"
)
Restaurant.create(
    name: "千代田レストラン",
    address: "東京都千代田区1-1-1",
    tel: '03-1234-5678',
    opentime: "平日12:00~21:00, 土日祭日10:00~21:00",
)
Restaurant.create(
    name: "港レストラン",
    address: "東京都港区1-1-1",
    tel: '03-1234-5678',
    opentime: "平日12:00~21:00, 土日祭日10:00~21:00",
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
User.create(
    name: "Amashou",
    email: "amano@example.com",
    password: "password",
    password_confirmation: "password"
)
User.create(
    name: "Tanaka",
    email: "tanaka@example.com",
    password: "password",
    password_confirmation: "password"
)
User.create(
    name: "Yamada",
    email: "yamada@example.com",
    password: "password",
    password_confirmation: "password"
)