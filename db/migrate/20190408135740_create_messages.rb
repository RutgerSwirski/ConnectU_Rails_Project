class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :sender
      t.references :recipient
      t.text :content

      t.timestamps
    end

    add_foreign_key :messages, :users, column: :sender_id, primary_key: :id
    add_foreign_key :messages, :users, column: :recipient_id, primary_key: :id
  end
end
