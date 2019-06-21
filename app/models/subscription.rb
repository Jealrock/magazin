class Subscription < ApplicationRecord
  belongs_to :user

  scope :by_user_category_subscriptions, lambda { |category_id|
    where(user: { category_subscriptions: { category_id: category_id } })
  }

  validates :endpoint, presence: true
  validates :p256dh, presence: true
  validates :auth, presence: true
end
