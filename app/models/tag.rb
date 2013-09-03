class Tag < ActiveRecord::Base
  has_many :groups, :through => :group_tags
  has_many :interests, :through => :interest_tags
  has_many :interest_tags, :dependent => :destroy
  has_many :group_tags,:dependent => :destroy
end
