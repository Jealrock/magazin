class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :photo, PhotoUploader
  geocoded_by :address, if: ->(obj) { obj.address.present? && obj.address_changed? } do |obj, results|
    if (location = results.first)
      obj.city = location.city
      obj.latitude = location.latitude
      obj.longitude = location.longitude
    end
  end

  scope :by_category_subscriptions, lambda { |category_ids|
    joins(:category_subscriptions)
      .where(category_subscriptions: { category_id: category_ids })
  }

  scope :by_cities, lambda { |cities|
    where(city: cities)
  }

  has_many :offers

  has_many :favorites
  has_many :favorite_offers, through: :favorites, source: :offer

  has_many :subscriptions

  has_many :category_subscriptions
  has_many :subscribed_categories, through: :category_subscriptions, source: :category

  after_validation :geocode

  def messages
    Message.with(id)
  end
end
