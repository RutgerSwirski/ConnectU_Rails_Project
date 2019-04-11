class AddTicketsToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :total_tickets, :integer
    add_column :activities, :available_tickets, :integer
  end
end
