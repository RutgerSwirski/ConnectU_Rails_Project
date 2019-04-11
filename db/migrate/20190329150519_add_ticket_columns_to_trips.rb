class AddTicketColumnsToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :ticket_name, :string
    add_column :trips, :ticket_description, :text
    add_column :trips, :ticket_quantity, :integer
    add_monetize :trips, :ticket_price, currency: { present: false }
    add_column :trips, :available_tickets, :integer

  end
end
