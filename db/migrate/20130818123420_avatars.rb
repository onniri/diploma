class Avatars < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.has_attached_file :avatar
    end
    change_table :interests do |t|
      t.has_attached_file :avatar
    end
    change_table :groups do |t|
      t.has_attached_file :avatar
    end

  end
end
