class Chat < ApplicationRecord
  belongs_to :application, class_name: "application", foreign_key: "application_id"
  has_many :messages, class_name: "message", foreign_key: "message_id"
end
