class Message < ActiveRecord::Base
#  attr_accessible :conversation_id, :is_read, :message_text, :post_date, :user_id
  belongs_to :conversation
  belongs_to :user
end
