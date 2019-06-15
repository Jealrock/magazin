class Offer < ApplicationRecord
  geocoded_by :address, if: ->(obj) { obj.address.present? && obj.address_changed? } do |obj, results|
    if (location = results.first)
      obj.address = location.address
      obj.city = location.city
      obj.latitude = location.latitude
      obj.longitude = location.longitude
    end
  end

  has_many :photos
  belongs_to :category
  belongs_to :user

  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user

  after_validation :geocode

  scope :opened, -> { where(closed: false) }
  scope :by_category_id, ->(id) { where(category_id: id) }
  scope :by_title, ->(title) { where('lower(offers.title) LIKE ?', "%#{title.downcase}%") }
  scope :by_city, ->(city) { where(city: city) }
  scope :by_type, ->(type) { where(type: type) }

  scope :min_price, ->(value) { where('offers.price >= ?', value) }
  scope :max_price, ->(value) { where('offers.price <= ?', value) }
  scope :min_date, ->(value) { where('offers.updated_at >= ?', value) }
  scope :max_date, ->(value) { where('offers.updated_at <= ?', value) }
  scope :only_with_photos, -> { joins(:photos) }

  def close
    self.closed = true
  end

  def close!
    close
    save!
  end
end
