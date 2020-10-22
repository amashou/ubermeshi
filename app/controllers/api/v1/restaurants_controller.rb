class Api::V1::RestaurantsController < ApiController
  before_action :authenticate_api_user!
  def index
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    #コントローラーで名前の一意性を確かめなくてもモデルに書いていればSave時にerrorsを出してくれる。
    # saved_restaurant = Restaurant.find_by(name: restaurant.name)
    # if saved_restaurant.name == restaurant.name
    #   render json: { message: 'already Created', data: saved_restaurant }
    if @restaurant.save
      render json: { message: 'Created!', data: @restaurant }
    else
      render json: { message: 'Not created!', data: @restaurant.errors }
    end
  end

  def destroy
  end

  private
    def restaurant_params
      params.require(:restaurantInfo).permit(:name, :address, :url, :restaurant_image, :tel, :opentime, :latitude, :longitude)
    end
    # t.string :name
    # t.string :address
    # t.string :url
    # t.string :restaurant_image
    # t.string :tel
    # t.string :opentime
    # t.float :latitude
    # t.float :longitude
end
