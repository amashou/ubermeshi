class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_api_user!


  def create
    follow = Relationship.new(follower_id: params[:user_id], following_id: current_api_user.id)
    user = User.find(params[:user_id])
    if follow.save
      followings_count = user.followings.count
      followers_count = user.followers.count
      render json: { status: "SUCCESS", message: "フォローしました", followings_count: followings_count, followers_count: followers_count }
    elsif Relationship.find_by(follower_id: params[:user_id], following_id: current_api_user.id).destroy
      followings_count = user.followings.count
      followers_count = user.followers.count
      render json: { status: "DESTROYED", message: "フォローを削除しました", followings_count: followings_count, followers_count: followers_count}
    end
  end

  def destroy
  end
end
