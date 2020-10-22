class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :url
      t.string :restaurant_image
      t.string :tel
      t.string :opentime
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
