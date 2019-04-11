class Activity < ApplicationRecord
  belongs_to :user

  monetize :price_cents

  validates :name, :price, :date, :description, :total_tickets, :address, presence: true

  has_many :reviews, dependent: :destroy
  has_many :activity_photos, dependent: :destroy
  has_many :orders, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
