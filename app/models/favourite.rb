class Favourite < ApplicationRecord
  belongs_to :trip, optional: true
  belongs_to :activity, optional: true
  belongs_to :flat, optional: true
  belongs_to :user
end
