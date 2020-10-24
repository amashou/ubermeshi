class Api::V1::UsersController < ApiController
  before_action :authenticate_api_user!, only: [:update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
    #=> User.select(:id, :name, :comment, :ubered_countm :status)???
    render json: @users.to_json
  end

  def show
    followings_count = @user.followings.count
    followers_count = @user.followers.count
    render json: { user: @user, followings_count: followings_count, followers_count: followers_count}
  end

  def edit
  end

  def update
    if current_api_user.id == @user.id && @user.update_attribute(user_params)
      render json: { status: 'SUCCESS', message: 'updated', data: @user }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @user.errors }
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :thumbnail, :profile_comment, :ubered_count)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
