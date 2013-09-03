class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.datetime :post_date
      t.boolean :is_read
      t.text :message_text
    end
    add_index :messages, :conversation_id
    add_index :messages, :user_id
    add_index :messages, :post_date
    create_table :conversations do |t|
      t.timestamps
      t.boolean :deleted, :default => false
    end
    create_table :conversations_users do |t|
      t.belongs_to :user
      t.belongs_to :conversation
    end
  end
end
