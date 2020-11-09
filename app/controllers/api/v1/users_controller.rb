class Api::V1::UsersController < ApiController
  before_action :authenticate_api_user!, only: [:update]
  before_action :set_user, only: [:show, :update, :posts, :follows, :comments, :favorite_posts]

  def index
    @users = User.all
    render json: @users
  end

  def posts
    render json: { posts: @user.posts }
  end
  
  def follows
    render json: { followers: @user.followers, followings: @user.followings } 
  end

  def comments
    render json: { comments: @user.comments, replys: @user.replys } 
  end

  def favorite_posts
    render json: { favorite_posts: @user.favorite_posts}
  end

  def show
    followings_count = @user.followings.count
    followers_count = @user.followers.count
    render json: { user: @user, followings_count: followings_count, followers_count: followers_count}
  end

  def update
    if @user.update_attributes(user_params)
      render json: { status: 'SUCCESS', message: '更新に成功しました', data: @user }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @user.errors.full_messages }
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :thumbnail, :profile_comment, :ubered_count, :address, :status)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
end
