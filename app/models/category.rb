class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'

  has_many :category_subscriptions
  has_many :subscribed_users, through: :category_subscriptions, source: :user

  validates :title, presence: true
end
