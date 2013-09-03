class CreateUserInterests < ActiveRecord::Migration
  def change
    create_table :user_interests do |t|
      t.integer :user_id
      t.integer :interest_id
      t.boolean :is_consumer, :default => true
    end
    add_index :user_interests, :user_id
    add_index :user_interests, :interest_id
  end
end
