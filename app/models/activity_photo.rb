class ActivityPhoto < ApplicationRecord
  belongs_to :activity

  mount_uploader :photo, PhotoUploader
end
