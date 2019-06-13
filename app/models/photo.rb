class Photo < ApplicationRecord
  belongs_to :offer, optional: true

  validates :file, presence: true

  mount_uploader :file, PhotoUploader
end
