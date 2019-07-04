class Payment < ApplicationRecord
  self.abstract_class = true

  STATUSES = [:pending, :failed, :successful].freeze

  enum status: STATUSES

  belongs_to :payable_entity, polymorphic: true

  def process
    raise NotImplementedError
  end

  def redirect_path
    raise NotImplementedError
  end
end
