class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.boolean :ticket_used, default: false
      t.string :qr_code
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
