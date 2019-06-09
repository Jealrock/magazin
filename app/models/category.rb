class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true

  validates :title, presence: true
end
