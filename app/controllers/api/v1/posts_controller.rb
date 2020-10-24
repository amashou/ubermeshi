class Api::V1::PostsController < ApiController
  before_action :authenticate_api_user!, except: [:index, :show]
  # before_action :authenticate_api_user!
  before_action :set_post, only: [:show]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end
  
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @restaurant = @post.restaurant
    @user = User.find(@post.user_id)
    @current_user = current_api_user
    favorites_count = @post.favorites.count
    comments = @post.comments
    render json: {post: @post, restaurant: @restaurant, user: @user, favorites_count: favorites_count, current_user: @current_user, comments: comments}
  end

  def create
    # @post = current_api_user.posts.new(post_params)
    # if @post.save
    #   render json: { status: 'SUCCESS', message: "Created!", data: @post }
    # else
    #   render json: { status: 'FAILURE', message: 'Not created!', data: @post.errors }
    # end

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
    # if restaurant.save
    #   post = restaurant.Post.new(post_params)
    #   if post.save
    #     posts = Post.all
    #     render json: { status: "SUCCESS", message: "Post and Restaurant created!", data: posts }
    #   else
    #     render json: { status: "Failed", message: "Post isn't created!"}
    #   end
    # else

    # end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def post_params
      params.require(:postInfo).permit(:title, :description,  :food_picture,)
    end

    def restaurant_params
      params.require(:restaurantInfo).permit(:name, :address, :url, :restaurant_image, :tel, :opentime, :latitude, :longitude, :id)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
