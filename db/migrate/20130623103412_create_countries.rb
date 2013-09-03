class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries, {:id=>false} do |t|
      t.string :iso_2letters, :limit => 2
      t.string :ascii_name
      t.integer :geo_id
    end
    execute 'ALTER TABLE countries ADD PRIMARY KEY (iso_2letters)'
    add_index :countries, :geo_id, {:unique => true}
    # dirty, but simple way to seed DB
    sql=File.open(Rails.root.join("db/countries.sql"))
    sql.each_line do |line|
      execute line
    end
  end
end
