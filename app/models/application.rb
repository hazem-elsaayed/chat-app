class Application < ApplicationRecord
  has_many :chats, class_name: "chat", foreign_key: "application_id"
  before_create :generate_token
  def generate_token(length=10)
    loop do
      token = self.token = SecureRandom.urlsafe_base64(length, false)
      break token unless self.class.exists?(token: token)
    end
  end
end
