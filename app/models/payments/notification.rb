class Payments::Notification < Payment
  DEFAULT_DESCRIPTION = 'Нотификация пользователей'.freeze
  AVAILABLE_PRICES = [ENV['PAYMENT_NOTIFICATION_TARGET_PRICE'].to_f, ENV['PAYMENT_NOTIFICATION_ALL_PRICE'].to_f].freeze

  validates :price, presence: true, inclusion: { in: AVAILABLE_PRICES }

  def process
    payable_entity.notify(params)
  end

  def successfull_redirect_path
    "/offer/#{payable_entity.id}?notified=true"
  end

  def failed_redirect_path
    "/offer/#{payable_entity.id}?notified=false"
  end

  def megakassa_params
    {
      shop_id: ENV['MEGAKASSA_SHOP_ID'],
      price: price,
      description: DEFAULT_DESCRIPTION,
      order_id: id,
      signature: generate_signature(
        [ENV['MEGAKASSA_SHOP_ID'], price, ENV['MEGAKASSA_DEFAULT_CURRENCY'],
         DEFAULT_DESCRIPTION, id, '', '', ENV['MEGAKASSA_DEBUG'], ENV['MEGAKASSA_SIGNATURE']],
        true
      )
    }
  end
end
