class CreateGroupsWalls < ActiveRecord::Migration
  def change
    create_table :groups_walls do |t|
      t.integer :wall_id
      t.integer :group_id

      t.timestamps
    end
    add_index :groups_walls,:wall_id
    add_index :groups_walls, :group_id
  end
end
