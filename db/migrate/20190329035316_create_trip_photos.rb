class CreateTripPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_photos do |t|
      t.string :photo, default: "dxwgaqkelr5kto0cpetf.jpg"
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
