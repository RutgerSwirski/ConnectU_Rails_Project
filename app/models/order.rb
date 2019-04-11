class Order < ApplicationRecord
  belongs_to :user
  belongs_to :trip, optional: true
  belongs_to :activity, optional: true
  belongs_to :flat, optional: true

  has_many :tickets, dependent: :destroy

  monetize :amount_cents

end
