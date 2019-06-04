class Offer < ApplicationRecord
  has_many :photos
  belongs_to :user

  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user

  scope :opened, -> { where(closed: false) }

  def close
    self.closed = true
  end

  def close!
    close
    save!
  end
end
