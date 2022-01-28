class ChatsController < ApplicationController
  def create
    return render json: { success: false, message: 'wrong params' }, status: 400 if params[:name].blank?
    last_chat = Chat.joins('JOIN applications ON applications.id = chats.application_id').where('applications.token' => params[:token]).last
    chat_number = last_chat.blank? ? 1 : last_chat.chat_number + 1
    application_id = last_chat.blank? ? Application.where(token: params[:token]).pluck(:id)[0] : last_chat.application_id
    new_chat = Chat.create(name: params[:name], chat_number: chat_number, messages_count: 0, application_id: application_id)
    render json: { success: true, chat_number: new_chat.chat_number }
  end

  def index
    chats = Chat.select("chats.name, chats.messages_count, chats.chat_number").joins('JOIN applications ON applications.id = chats.application_id').where('applications.token' => params[:token])
    render json: { success: true, data: chats }
  end
  
end
