class AddNumberOfPeopleToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :number_of_guests, :integer
  end
end
