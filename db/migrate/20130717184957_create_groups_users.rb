class CreateGroupsUsers < ActiveRecord::Migration
  def change
    create_table :groups_users do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :is_admin, :default => false
      t.boolean :is_moderator, :default => false
      t.boolean :read_only, :default => false

      t.timestamps
    end
    add_index :groups_users, :user_id
    add_index :groups_users, :group_id
  end
end
