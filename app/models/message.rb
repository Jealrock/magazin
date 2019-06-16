class Message < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validates :text, presence: true

  scope :with, ->(user_id) { where('from_user_id = ? OR to_user_id = ?', user_id, user_id) }
  scope :ordered_by_time, -> { order(:created_at) }
end
