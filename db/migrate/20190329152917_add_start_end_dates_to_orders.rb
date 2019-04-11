class AddStartEndDatesToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :flat_booked_start, :date
    add_column :orders, :flat_booked_end, :date
  end
end
