class Offer < ApplicationRecord
  has_many :photos
  belongs_to :user

  scope :opened, -> { where(closed: false) }

  def close
    self.closed = true
  end

  def close!
    close
    save!
  end
end
