class GroupsUser < ActiveRecord::Base
#  attr_accessible :group_id, :is_admin, :is_moderator, :read_only, :user_id
  belongs_to :user
  belongs_to :group
end
