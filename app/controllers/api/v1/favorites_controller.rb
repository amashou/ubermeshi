class Api::V1::FavoritesController < ApiController
  before_action :authenticate_api_user!

  def create
    favorite = current_api_user.favorites.new(post_id: params[:post_id],)
    post = Post.find(params[:post_id])
    if current_api_user.id == post.user_id
      render json: { message: "cannot favorites your post"}
    elsif favorite.save
      render json: { status: "SUCCESS", message: 'favorited', data: current_api_user}
    else
      render json: { status: "FAILURE", message: 'Not favorited', data: params[:post_id]}
    end
  end

  def destroy
    favorite = current_api_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy
    render json: { status: 'SUCCESS', message: 'unfavorited', data: current_api_user.favorites.count}
  end

end
