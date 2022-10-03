class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :chat_number, index: true
      t.integer :messages_count
      t.string :name
      t.references :application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
