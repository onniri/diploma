class CreateWalls < ActiveRecord::Migration
  def change
    create_table :walls do |t|
      t.boolean :is_readonly, :default => false

      t.timestamps
    end
  end
end
