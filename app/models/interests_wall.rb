class InterestsWall < ActiveRecord::Base
  belongs_to :interest
  belongs_to :wall
end
