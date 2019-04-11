class CreateFlatPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :flat_photos do |t|
      t.string :photo
      t.references :flat, foreign_key: true

      t.timestamps
    end
  end
end
