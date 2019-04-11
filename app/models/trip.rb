class Trip < ApplicationRecord
  belongs_to :user

  has_many :reviews, dependent: :destroy
  has_many :trip_photos, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :tickets, through: :orders, dependent: :destroy

  monetize :funding_total_cents
  monetize :current_funding_amount_cents
  monetize :ticket_price_cents

  validates :name, :destination, :departing_from, :funding_total, :date_arriving, :date_leaving, presence: true
  
  geocoded_by :destination
  after_validation :geocode, if: :will_save_change_to_destination?
end
