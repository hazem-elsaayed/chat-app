class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :message
      t.string :sender
      t.integer :message_number, index: true
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
