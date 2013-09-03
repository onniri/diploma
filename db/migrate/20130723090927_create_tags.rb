class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
      t.integer :hits

      t.timestamps
    end
    add_index :tags, :tag
  end
end
