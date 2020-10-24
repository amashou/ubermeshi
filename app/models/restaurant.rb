class Restaurant < ApplicationRecord
    mount_uploader :restaurant_image, PictureUploader
    has_many :posts
    validates :name, uniqueness: true
end
