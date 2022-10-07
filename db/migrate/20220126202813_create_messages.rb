class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.string :sender, null: false
      t.integer :message_number, index: true, unique: true
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
