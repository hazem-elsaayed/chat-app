class Application < ApplicationRecord
  has_many :chats, class_name: "chat", foreign_key: "application_id"
end
