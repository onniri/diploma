class Wall < ActiveRecord::Base
  has_many :wall_messages
  has_one :user, :through => :users_walls
end
