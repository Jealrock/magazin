class Payment < ApplicationRecord
  STATUSES = { pending: 0, successful: 1, failed: 2 }.freeze
  STI_CLASSES = ['Payments::Notification'].freeze

  enum status: STATUSES
  validates :type, inclusion: { in: STI_CLASSES }

  belongs_to :payable_entity, polymorphic: true

  def process
    raise NotImplementedError
  end

  def successfull_redirect_path
    raise NotImplementedError
  end

  def failed_redirect_path
    raise NotImplementedError
  end

  def megakassa_params
    raise NotImplementedError
  end
end
