class Review < ApplicationRecord
  belongs_to :user
  belongs_to :trip, optional: true
  belongs_to :activity, optional: true
  belongs_to :flat, optional: true

  validates :rating, inclusion: 1..5, presence: true
  validates :review_content, presence: true
end
