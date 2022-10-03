class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token, null: false, unique: true, index: true
      t.integer :chats_count

      t.timestamps
    end
  end
end
