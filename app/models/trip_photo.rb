class TripPhoto < ApplicationRecord
  belongs_to :trip
  mount_uploader :photo, PhotoUploader
end
