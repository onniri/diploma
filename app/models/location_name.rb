class LocationName < ActiveRecord::Base
#  attr_accessible :geo_id, :lang
  belongs_to :country, :foreign_key => :geo_id
  belongs_to :location, :foreign_key => :geo_id
end
