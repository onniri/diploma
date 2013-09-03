class Location < ActiveRecord::Base
  self.primary_key=:geo_id
#  attr_accessible :ascii_name, :country, :geo_id, :latitude, :longtitude
  belongs_to :country, :foreign_key => :country
  has_many :users, :foreign_key => :location_id
  has_many :location_names, :foreign_key => :geo_id
end
