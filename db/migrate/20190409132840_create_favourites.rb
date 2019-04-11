class CreateFavourites < ActiveRecord::Migration[5.2]
  def change
    create_table :favourites do |t|
      t.references :trip, foreign_key: true
      t.references :activity, foreign_key: true
      t.references :flat, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
