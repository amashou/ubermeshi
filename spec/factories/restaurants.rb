FactoryBot.define do
  factory :restaurant do
    name              { "test_restaurant_name" }
    address           { "渋谷区1-1-1"}
    url               { "http://test.url" }
    restaurant_image  { "restaurant_image_test" }
    tel               { "000-0000-0000" }
    opentime          { "平日00:00~11:11,定休日：毎週火曜日" }
    latitude          { "000" }
    longitude         { "000" }
  end
end
