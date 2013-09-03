class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations, {:id=>false} do |t|
      t.integer :geo_id
      t.string :ascii_name
      t.float :latitude
      t.float :longtitude
      t.string :country , :limit => 2
    end
    execute 'ALTER TABLE locations ADD PRIMARY KEY (geo_id)'
    add_index :locations, :country
    # dirty, but simple way to seed DB
    sql=File.open(Rails.root.join("db/locations.sql"))
    sql.each_line do |line|
      execute line
    end
  end
end
