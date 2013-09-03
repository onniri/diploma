class CreateLocationNames < ActiveRecord::Migration
  def change
    create_table :location_names do |t|
      t.string :lang
      t.integer :geo_id
      t.string :name
    end
    add_index :location_names, :lang
    add_index :location_names, :geo_id
    # dirty, but simple way to seed DB
    sql=File.open(Rails.root.join("db/location_names.sql"))
    sql.each_line do |line|
      execute line
    end
  end
end
