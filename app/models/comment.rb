class Comment < ApplicationRecord

    belongs_to :user
    belongs_to :post
    has_many :replys, dependent: :destroy

    validates :content, presence: true, length: { maximum: 140 }
    
end
