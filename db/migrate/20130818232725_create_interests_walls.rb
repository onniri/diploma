class CreateInterestsWalls < ActiveRecord::Migration
  def change
    create_table :interests_walls do |t|

      t.timestamps
    end
  end
end
