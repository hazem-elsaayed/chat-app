class MessagesController < ApplicationController
  def create
    return render json: { success: false, message: 'wrong params' }, status: 400 if params[:sender].blank? or params[:message].blank?
    last_message = Message.joins(chat: :application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number]).last
    message_number = last_message.blank? ? 1 : last_message.message_number + 1
    chat_id = last_message.blank? ? Chat.joins(:application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number]).pluck(:id)[0] : last_message.chat_id
    new_message = Message.create(message: params[:message], sender: params[:sender], chat_id: chat_id, message_number: message_number)
    render json: { success: true, message_number: new_message.message_number }
  end
  
end
