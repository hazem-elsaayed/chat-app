class Chat < ApplicationRecord
  belongs_to :application, class_name: "Application", foreign_key: "application_id"
  has_many :message, class_name: "Message", foreign_key: "message_id"
  validates :name, presence: true
end
