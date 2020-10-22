class Restaurant < ApplicationRecord
    mount_uploader :restaurant_image, ReastaurantImageUploader


    has_many :posts
    validates :name, uniqueness: true

end
