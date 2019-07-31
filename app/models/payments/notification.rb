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
      shop_id: ENV['FREEKASSA_SHOP_ID'],
      price: price,
      description: DEFAULT_DESCRIPTION,
      order_id: id,
      signature: Freekassa.generate_signature(
        [ENV['FREEKASSA_SHOP_ID'], Freekassa.format_price(price), ENV['FREEKASSA_SIGNATURE'], id]
      )
    }
  end
end
