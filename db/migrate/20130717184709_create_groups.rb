class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.integer :creator_user_id
      t.text :motd
      t.boolean :public, :default => true

      t.timestamps
    end
    add_index :groups, :name
    add_index :groups, :description
  end
end
