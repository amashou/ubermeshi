class Api::V1::PostsController < ApiController
  before_action :authenticate_api_user!, except: [:index, :show]
  # before_action :authenticate_api_user!
  before_action :set_post, only: [:show]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end
  
  def index
    posts = Post.all
    render json: { posts: posts, user: current_api_user }
  end

  def show
    render json: @post
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    post = restaurant.posts.build(post_params)
    post.user_id = current_api_user.id
    restaurant.save
    if post.save
      render json: { status: "SUCCESS", message: "post created" }
    else
      render json: { status: "FAILED", errors: post.errors.full_messages }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def post_params
      params.require(:postInfo).permit(:title, :description, :food_picture, :restaurant_name, :restaurant_address)
    end

    def restaurant_params
      params.require(:restaurantInfo).permit(:name, :address, :url, :restaurant_image, :tel, :opentime, :latitude, :longitude, :id)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
