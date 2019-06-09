class Offer < ApplicationRecord
  geocoded_by :address, if: ->(obj) { obj.address.present? && obj.address_changed? }

  has_many :photos
  belongs_to :category
  belongs_to :user

  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user

  after_validation :geocode

  scope :opened, -> { where(closed: false) }

  def close
    self.closed = true
  end

  def close!
    close
    save!
  end
end
