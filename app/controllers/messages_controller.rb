class MessagesController < ApplicationController
include SessionsHelper

  def create
    unless params[:message_text].empty?
      @message = Message.new
      @message.message_text=params[:message_text]
      @message.user=current_user
      @message.conversation=Conversation.find(params[:conversation_id])
      @message.is_read=false
      @message.post_date=DateTime.current
      @message.save
    end

  end
end
