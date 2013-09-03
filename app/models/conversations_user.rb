class ConversationsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
end
