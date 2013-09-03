class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :unread_messages_count
  def unread_messages_count
    query = "SELECT
    COUNT(
        messages.id
    )
    FROM
    public.conversations_users,
        public.conversations,
        public.messages
    WHERE
    conversations_users.conversation_id = conversations.id AND
    messages.conversation_id = conversations.id AND
    conversations_users.user_id=#{current_user.id} AND
    messages.is_read=false AND
    messages.user_id!=#{current_user.id};"
    result = ActiveRecord::Base.connection.execute(query)
    Rails.logger.debug("ressult-count: #{result[0]['count']}")
    return (result[0]['count']).to_i
  end
end
