class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_api_user!


  def create
    follow = Relationship.new(follower_id: params[:user_id], following_id: current_api_user.id )
    user = User.find(params[:user_id])
    if Relationship.find_by(follower_id: params[:user_id], following_id: current_api_user.id )
      render json: { status: "Failed", message: "aleady followed"}
    elsif follow.save
      followings_count = user.followings.count
      followers_count = user.followers.count
      render json: { status: "SUCCESS", message: "followed", followings_count: followings_count, followers_count: followers_count }
    else
      render json: { status: "Failed", message: "Not follow" }
    end
  end

  def destroy
    unfollow = Relationship.find_by(follower_id: params[:user_id], following_id: current_api_user.id)
    user = User.find(params[:user_id])
    if !unfollow
      render json: { status: "Failed", message: "Not followed" }
    elsif unfollow.destroy
      followers_count = user.followers.count
      followings_count = user.followings.count
      render json: { status: "SUCCESS", message: "unfollowed", followers_count: followers_count, followings_count: followings_count }
    else
      render json: { status: "Failed", message: "not unfollow"}
    end
  end
end
