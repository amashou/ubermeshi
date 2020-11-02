class Api::V1::ReplySerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :comment_id, :updated_at
end
