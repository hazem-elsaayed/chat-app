class ChatsController < ApplicationController
  def create
    return render json: { success: false, message: 'wrong params' }, status: 400 if params[:name].blank?
    new_chat = {}
    Chat.transaction(isolation: :serializable) do
      last_chat = Chat.joins(:application).where('applications.token' => params[:token]).last
      chat_number = last_chat.blank? ? 1 : last_chat.chat_number + 1
      application_id = last_chat.blank? ? Application.where(token: params[:token]).pluck(:id)[0] : last_chat.application_id
      new_chat = Chat.create(name: params[:name], chat_number: chat_number, messages_count: 0, application_id: application_id)
    end  
    render json: { success: true, chat_number: new_chat.chat_number }
  end

  def index
    chats = Chat.select("chats.name, chats.messages_count, chats.chat_number").joins(:application).where('applications.token' => params[:token])
    render json: { success: true, data: chats }
  end

  def show
    chat = Chat.select("chats.name, chats.messages_count, chats.chat_number").joins(:application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number])
    return render json: { success: false, message: 'chat not found' }, status: 404 if chat.blank?
    render json: { success: true, data: chat }
  end
  
  def update
    Chat.transaction do
      chat = Chat.joins(:application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number])
      return render json: { success: false, message: 'wrong params' }, status: 400 if params[:name].blank? or chat.blank?
      if chat.update(name: params[:name])
        render json: { success: true, message: "successfully updated" }
      else
        render json: { success: false, message: 'wrong params' }, status: 404
      end
    end
  end
end
