class MessagesController < ApplicationController
  def create
    return render json: { success: false, message: 'wrong params' }, status: 400 if params[:sender].blank? or params[:message].blank?
    last_message = Message.joins(chat: :application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number]).last
    message_number = last_message.blank? ? 1 : last_message.message_number + 1
    chat_id = last_message.blank? ? Chat.joins(:application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number]).pluck(:id)[0] : last_message.chat_id
    new_message = Message.create(message: params[:message], sender: params[:sender], chat_id: chat_id, message_number: message_number)
    render json: { success: true, message_number: new_message.message_number }
  end
  
  def index
    messages = Message.select("sender, message, message_number").joins(chat: :application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number])
    render json: { success: true, data: messages }
  end

  def show
    message = Message.select("sender, message, message_number").joins(chat: :application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number]).where('messages.message_number' => params[:message_number]).first
    return render json: { success: false, message: 'message not found' }, status: 404 if message.blank?
    render json: { success: true, data: message }
  end
  
  def update
    message = Message.joins(chat: :application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number]).where('messages.message_number' => params[:message_number])
    return render json: { success: false, message: 'wrong params' }, status: 400 if (params[:sender].blank? and params[:message]) or message.blank?
    if message.update(message_params)
      render json: { success: true, message: "successfully updated" }
    else
      render json: { success: false, message: 'wrong params' }, status: 404
    end
  end

  def search
    chat_id = Chat.joins(:application).where('applications.token' => params[:token]).where('chats.chat_number' => params[:chat_number]).pluck(:id)[0]
    return render json: { success: false, message: 'wrong params' }, status: 400 if params[:query].blank? or chat_id.blank?
    query = MessageIndex.search(params[:query].to_s).where(chat_id: chat_id)
    data = query.records.blank? ? [] : removeId(query.records)
    render json: { success: true, data: data, count: query.total_entries }
  end

  private
    def message_params
      params.permit(:sender, :message)
    end
  private
    def removeId(data)
      result = []
      data.each do |e|
        row = { sender: e.sender, message: e.message, message_number: e.message_number }
        result << row
      end
      return result
    end

end
