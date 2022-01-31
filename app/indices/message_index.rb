class MessageIndex
  include SearchFlip::Index

  def self.index_name
    "message"
  end

  def self.model
    Message
  end

  def self.serialize(message)
    {
      id: message.id,
      message: message.message,
      sender: message.sender,
      message_number: message.message_number,
      chat_id: message.chat_id,
    }
  end
end