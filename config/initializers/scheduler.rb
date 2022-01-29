require 'rufus-scheduler'
s = Rufus::Scheduler.singleton

s.every '45m' do
  chats_count = Chat.select("application_id, count(id) as count").group("application_id")
  messages_count = Message.select("chat_id, count(id) as count").group("chat_id")
  # puts messages_count.to_json
  for entity in chats_count do
    Application.where(id: entity.application_id).update(chats_count: entity.count)
  end
  for entity in messages_count do
    Chat.where(id: entity.chat_id).update(messages_count: entity.count)
  end
  # puts message.message
  Rails.logger.info "hello, it's #{Time.now}"
  Rails.logger.flush
end