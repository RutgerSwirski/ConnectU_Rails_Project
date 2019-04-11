class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :destination
      t.date :date_arriving
      t.date :date_leaving
      t.string :departing_from
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
