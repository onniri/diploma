class GroupsWall < ActiveRecord::Base
  belongs_to :group
  belongs_to :wall
end
