class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :food_picture

  has_many :comments, serializer: Api::V1::CommentSerializer


  attribute :restaurantInfo do
    Restaurant.find(object.restaurant_id)
  end

  attribute :userInfo do
    User.find(object.user_id)
  end
  
  attribute :favorites_count do
    object.favorites.count
  end

end
