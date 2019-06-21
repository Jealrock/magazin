class CategorySubscription < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :user_id, uniqueness: { scope: :category_id,
                                    message: 'already exists' }
end
