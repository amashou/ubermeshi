class Post < ApplicationRecord
    mount_uploader :images, ImageUploader
    belongs_to :user
    belongs_to :restaurant

    has_many :favorites
    has_many :favorited_users, through: :favorites, source: :user

    def favorited_by(user)
        favorites.where(user_id: user.id).exists?
    end
end
