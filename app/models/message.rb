class Message < ApplicationRecord
  include SearchFlip::Model
  validates :sender, :content, :message_number, presence: true
  validates :message_number, uniqueness: true
  belongs_to :chat, class_name: "Chat", foreign_key: "chat_id"
  notifies_index(MessageIndex)
end
