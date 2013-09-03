class Conversation < ActiveRecord::Base
#  attr_accessible :deleted
  has_many :conversations_users
  has_many :users, :through => :conversations_users
  has_many :messages
  def opposite_user(current_user)
    return self.users.where("users.id != #{current_user.id}").first
  end
end
