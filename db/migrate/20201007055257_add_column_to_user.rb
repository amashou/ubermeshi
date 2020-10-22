class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_comment, :string
    add_column :users, :ubered_count, :integer
    add_column :users, :status, :integer
  end
end
