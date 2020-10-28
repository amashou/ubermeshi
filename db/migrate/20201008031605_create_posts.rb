class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :title
      t.string :description
      t.string :food_picture
      t.string :restaurant_name
      t.string :restaurant_address

      t.timestamps
    end
  end
end
