class AddFlatsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :flat, foreign_key: true
  end
end
