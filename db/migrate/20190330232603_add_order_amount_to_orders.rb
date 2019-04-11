class AddOrderAmountToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :number_of_orders, :integer
  end
end
