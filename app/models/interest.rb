class Interest < ActiveRecord::Base
  include PgSearch
  has_many :users, :through => :user_interests
  has_many :user_interests, :dependent => :destroy
  has_many :tags, :through => :interest_tags
  has_many :interest_tags, :dependent => :destroy
  has_one :wall, :through => :interests_walls
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  pg_search_scope :interest_search, :against => [:title , :description], :using => {:tsearch => {:dictionary => 'english', :prefix => true}}

end
