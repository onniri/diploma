class ConversationsController < ApplicationController
include SessionsHelper
  def index
    if ((current_user.id) != (params[:user_id].to_i))
      flash[:error] = "You don't have permission to access other's users conversations"
    end
    @conversations = current_user.conversations
  end

  def show
    # TODO: make this dynamic loading last 10 messages and infinite scrolling up
    @conversation = current_user.conversations.find(params[:id])
    @messages = @conversation.messages
    @messages.where('messages.user_id!=?', current_user.id).where(:is_read => false).update_all(:is_read=>true)

  end

  def new
    conv = ConversationsUser.find_by_sql([
    'SELECT t1.id AS id,t1.user_id AS user_id,t1.conversation_id AS conversation_id FROM
     conversations_users t1, conversations_users t2 where t1.conversation_id=t2.conversation_id
     AND t1.user_id=? AND t2.user_id=?',
        current_user.id,
        params[:user_id]])
    if conv.count == 0
      conv = Conversation.create
      conv.users = [current_user, User.find(params[:user_id])]
      redirect_to user_conversation_path current_user,conv
      return
    end
    redirect_to user_conversation_path current_user,conv.first.conversation
  end
end
