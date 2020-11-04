class Api::V1::FavoritesController < ApiController
  before_action :authenticate_api_user!

  def create
    # favorite = Favorite.new(post_id: params[:post_id], user_id: current_api_user.id)
    post = Post.find(params[:post_id])
    favorite = post.favorites.new(user_id: current_api_user.id)

    if favorite.save
      render json: { status: "Created", favorites_count: post.favorites.count}
    else 
      post.favorites.find_by(user_id: current_api_user.id).destroy
      render json: { status: "Destroyed", favorites_count: post.favorites.count}
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
