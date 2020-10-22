class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :title
      t.string :description
      t.string :restaurant_name
      t.integer :times
      t.string :images

      t.timestamps
    end
  end
end
