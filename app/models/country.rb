class Country < ActiveRecord::Base
  self.primary_key=:iso_2letters
#  attr_accessible :ascii_name, :geo_id, :iso_2letters
  has_many :locations, :foreign_key => :country
  has_many :location_names, :foreign_key => :geo_id, :primary_key => :geo_id
end
