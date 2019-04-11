class FlatPhoto < ApplicationRecord
  belongs_to :flat

  validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
end
