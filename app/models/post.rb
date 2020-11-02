class Post < ApplicationRecord
    mount_uploader :food_picture, PictureUploader
    belongs_to :user
    belongs_to :restaurant

    has_many :favorites, dependent: :destroy
    has_many :favorited_users, through: :favorites, source: :user
    has_many :comments, dependent: :destroy
    
end
