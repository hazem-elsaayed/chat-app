class Message < ApplicationRecord
  include SearchFlip::Model
  belongs_to :chat, class_name: "Chat", foreign_key: "chat_id"
  notifies_index(MessageIndex)
end
