class AddFundingToTrips < ActiveRecord::Migration[5.2]
  def change
    add_monetize :trips, :funding_total, currency: { present: false }
    add_monetize :trips, :current_funding_amount, currency: { present: false }
  end
end
