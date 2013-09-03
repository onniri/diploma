class Group < ActiveRecord::Base
#  attr_accessible :creator_user_id, :description, :motd, :name, :public
  has_many :groups_users, :dependent => :destroy
  has_many :users, :through => :groups_users
  has_many :tags, :through => :group_tags
  has_many :group_tags, :dependent => :destroy
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_one :wall, :through => :groups_walls

  def has_user(user)
    self.users.where(:id=>user.id).count == 1
  end
  def is_admin?(user)
    self.groups_users.where(:user_id => user.id).first.is_admin?
  end
  def is_moderator?(user)
    self.groups_users.where(:user_id => user.id).first.is_moderator?
  end
end
