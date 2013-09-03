class CreateGroupTags < ActiveRecord::Migration
  def change
    create_table :group_tags do |t|
      t.integer :group_id
      t.integer :tag_id
      t.integer :hits
    end
    add_index :group_tags, :group_id
    add_index :group_tags, :tag_id
  end
end
