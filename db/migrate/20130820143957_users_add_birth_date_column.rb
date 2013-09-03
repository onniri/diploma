class UsersAddBirthDateColumn < ActiveRecord::Migration
  def change
    add_column :users, :birth_date, :date
    add_column :users, :is_age_visible, :boolean
  end
end
