class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.datetime :registration_date
      t.boolean :registered
      t.datetime :last_online_date
      t.float :range
      t.boolean :deleted
      t.datetime :delete_date
      t.string :skype
      t.boolean :email_public
      t.string :jabber
      t.string :location_name
      t.boolean :site_admin
      t.boolean :banned
      t.datetime :ban_date
      t.datetime :banned_till
      t.timestamps
    end
  end
end
