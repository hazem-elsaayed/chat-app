class Message < ApplicationRecord
  belongs_to :chat, class_name: "chat", foreign_key: "chat_id"
end
