class CreateActivityPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_photos do |t|
      t.string :photo, default: 'fachry-zella-devandra-714239-unsplash_1.jpg'
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
