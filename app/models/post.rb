class Post < ApplicationRecord
    mount_uploader :food_picture, PictureUploader
    belongs_to :user
    belongs_to :restaurant

    has_many :favorites, dependent: :destroy
    has_many :favorited_users, through: :favorites, source: :user
    has_many :comments, dependent: :destroy

    validates :title, presence: true, length: { maximum: 30 }
    validates :description, presence: true, length: { maximum: 140 }
    validate :food_picture_size

    private

        def food_picture_size
            if food_picture.size > 5.megabytes
                errors.add(:food_picture, "5MB以下でのファイルにしてください")
            end
        end

    
end
