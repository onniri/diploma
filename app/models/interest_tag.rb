class InterestTag < ActiveRecord::Base
  belongs_to :interest
  belongs_to :tag
end
