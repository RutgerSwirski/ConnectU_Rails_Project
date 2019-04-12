class CreateActivityPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_photos do |t|
      t.string :photo, default: 'jgzmvpaumlt326d8fcal.jpg'
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
