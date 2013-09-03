class GroupTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :group
end
