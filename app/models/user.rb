class User < ActiveRecord::Base
  include PgSearch
  # TODO: administrative restrictions!
#  attr_accessible :ban_date, :banned, :banned_till, :delete_date, :deleted, :email, :email_public, :first_name, :jabber, :last_online_date, :last_name, :location_name, :range, :registered, :registration_date, :site_admin, :skype, :password, :password_confirmation, :location_id
  has_secure_password
  has_many :messages, :foreign_key => :from
  belongs_to :location, :foreign_key => :location_id
  has_many :conversations_users
  has_many :conversations, :through => :conversations_users
  has_many :groups_users
  has_many :groups, :through => :groups_users
  has_many :user_interests
  has_many :interests, :through => :user_interests
  has_one :wall, :through => :users_wall
  has_one :users_wall
  has_many :wall_messages
  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100>", :tiny => '48x48>' }, :default_url => ActionController::Base.helpers.image_path('no-avatar.png')
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  def age
    ((Date.current-self.birth_date)/365).to_i
  end
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email
  validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ },
            :length => {:maximum => 50, :minimum => 10}
  validates :skype, :length => {:maximum => 50,:minimum => 3}, :allow_blank => true
  validates :first_name, :length => {:maximum => 30,:minimum => 3}
  validates :last_name, :length => {:maximum => 30,:minimum => 3}
  validates :location_name, :length => {:maximum => 50,:minimum => 3}, :allow_blank => true
  validates :jabber, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ },
            :length => {:maximum => 50, :minimum => 10}, :allow_blank => true
  validates :range, :numericality => {:greater_than => 10}

  pg_search_scope :name_search, :against => [:first_name, :last_name], :using => {:tsearch => {:dictionary => 'english', :prefix => true}}

  before_save {|u|
    u.email = email.downcase
  }
  before_create{|u|
    u.registration_date = DateTime.current
    u.range=100.0
    mw=Wall.new
    mw.save
    u.wall=mw
  }
  before_validation {|u|
    u.range=100.0
  }
  def name
    return "#{self.first_name} #{self.last_name}"
  end
  def is_interested_in(interest)
    return (self.interests.where(:id => interest.id).count>0)
  end
end
