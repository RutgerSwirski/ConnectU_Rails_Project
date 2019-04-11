class Flat < ApplicationRecord
  belongs_to :user
  validates :name, :description, :address, :price, presence: true

  monetize :price_cents

  has_many :reviews, dependent: :destroy
  has_many :flat_photos, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :amenities
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
