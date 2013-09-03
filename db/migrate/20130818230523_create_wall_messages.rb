class CreateWallMessages < ActiveRecord::Migration
  def change
    create_table :wall_messages do |t|
      t.integer :wall_id
      t.integer :user_id
      t.text :message
      t.timestamps
    end
    add_index :wall_messages, :wall_id
    add_index :wall_messages, :user_id
  end
end
