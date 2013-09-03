class CreateInterestTags < ActiveRecord::Migration
  def change
    create_table :interest_tags do |t|
      t.integer :interest_id
      t.integer :tag_id
      t.integer :hits
    end
    add_index :interest_tags, :interest_id
    add_index :interest_tags, :tag_id
  end
end
