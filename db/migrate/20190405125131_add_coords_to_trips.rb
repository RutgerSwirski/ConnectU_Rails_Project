class AddCoordsToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :longitude, :float
    add_column :trips, :latitude, :float
  end
end
