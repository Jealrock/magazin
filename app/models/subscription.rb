class Subscription < ApplicationRecord
  belongs_to :user

  scope :by_user_category_subscriptions, lambda { |category_ids|
    joins(user: [:category_subscriptions])
      .where(user: { category_subscriptions: { category_id: category_ids } })
  }

  scope :by_user_cities, lambda { |cities|
    joins(:user).where(users: { city: cities })
  }

  validates :endpoint, presence: true
  validates :p256dh, presence: true
  validates :auth, presence: true
end
