class Offer < ApplicationRecord
  belongs_to :user

  scope :open, -> { where(closed: false) }

  def close
    self.closed = true
  end

  def close!
    close
    save!
  end
end
