class Api::V1::FavoritesController < ApiController
  before_action :authenticate_api_user!

  def create
    favorite = Favorite.new(post_id: params[:post_id], user_id: current_api_user.id)
    post = Post.find(params[:post_id])
    if current_api_user.id == post.user_id
      render json: { message: "cannot favorites your post"}
    elsif post.favorites.where(user_id: current_api_user).exists?
      render json: {message: "already favorited"}
    elsif favorite.save
      favorites_count = post.favorites.count
      render json: { status: "SUCCESS", message: 'favorited', favorites_count: favorites_count}
    else
      render json: { status: "FAILURE", message: 'Not favorited', data: params[:post_id]}
    end
  end

  def destroy
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_api_user.id)
    if favorite.destroy
      render json: { status: 'SUCCESS', message: 'unfavorited', favorites_count: current_api_user.favorites.count}
    else
      render json: { status: "Failed", message: "Not favorited", favorites_count: current_api_user.favorites.count}
    end
  end

end
