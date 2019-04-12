class CreateFlatPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :flat_photos do |t|
      t.string :photo, default: "l7i9qo6gxliuk2s4hazi.jpg"
      t.references :flat, foreign_key: true

      t.timestamps
    end
  end
end
