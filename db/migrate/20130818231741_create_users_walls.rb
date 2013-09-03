class CreateUsersWalls < ActiveRecord::Migration
  def change
    create_table :users_walls do |t|
      t.integer :user_id
      t.integer :wall_id
      t.timestamps
    end
    add_index :users_walls, :user_id
    add_index :users_walls, :wall_id
  end
end
