class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.string :status
      t.references :sender
      t.references :recipient

      t.timestamps
    end

    add_foreign_key :friends, :users, column: :sender_id, primary_key: :id
    add_foreign_key :friends, :users, column: :recipient_id, primary_key: :id
  end
end
