class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.date :date
      t.string :address
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
