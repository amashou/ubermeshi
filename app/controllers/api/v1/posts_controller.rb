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
    # @post.comments(:replys)
    # @favorites_count = @post.favorites.count
    render json: @post
    # render json: @post, include: { comments: [:replys] }
    # @restaurant = @post.restaurant
    # @user = @post.user
    # comments = @post.comments.order(updated_at: "DESC")
    # @current_user = current_api_user
    # render json: {post: @post, restaurant: @restaurant, user: @user, favorites_count: @favorites_count, current_user: @current_user, comments: comments, replys: @replys}
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    post = restaurant.posts.build(post_params)
    post.user_id = current_api_user.id

    if restaurant.save
      if post.save
        render json: { message: "Restaurant and Post are created" }
      else
        render json: { message: "Restaurant created, but Post isn't created"}
      end
    else
      if post.save
        render json: { message: "Just post created"}
      else
        render json: { message: "Restaurant and Post aren't created" }
      end
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
