class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :replys, :user_id, :post_id, :updated_at

  has_many :replys, serializer: Api::V1::ReplySerializer
end
