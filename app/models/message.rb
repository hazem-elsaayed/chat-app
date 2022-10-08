class Message < ApplicationRecord
  # include SearchFlip::Model
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name Rails.application.class.parent_name.underscore
  document_type name.downcase

  validates :sender, :content, :message_number, presence: true
  validates :message_number, uniqueness: true
  belongs_to :chat, class_name: 'Chat', foreign_key: 'chat_id'
  # notifies_index(MessageIndex)

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :sender, type: :text, analyzer: 'english'
      indexes :content, type: :text, analyzer: 'english'
    end
  end

  def self.search(query, chat_id)
    __elasticsearch__.search(
      {
        query: {
          bool: {
            must: {
              query_string: {
                query: "*#{query}*",
                fields: ['content^5', 'sender']
              }
            },
            filter: {
              term: {
                chat_id: chat_id
              }
            }
          }
        }
      }
    )
  end
end
