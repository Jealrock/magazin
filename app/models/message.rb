class Message < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validates :text, presence: true

  scope :with, ->(user_id) { where('from_user_id = ? OR to_user_id = ?', user_id, user_id) }
  scope :ordered_by_time, -> { order(:created_at) }
  scope :recent_messages_with, lambda { |user_id|
    first_message_query = Message.send(
      :sanitize_sql_for_conditions, [
        "SELECT first_message.id FROM (
           select id, rank() OVER (
            PARTITION BY
              CASE
                WHEN from_user_id = :user_id then to_user_id
                ELSE from_user_id
              END
            ORDER BY created_at DESC
           ) from messages where from_user_id = :user_id OR to_user_id = :user_id
         ) as first_message where rank = 1",
        { user_id: user_id }
      ]
    )

    joins("JOIN (#{first_message_query}) as first_message on first_message.id = messages.id")
  }
end
