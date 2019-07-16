class Payments::Notification < Payment
  DEFAULT_AMOUNT = 1
  DEFAULT_DESCRIPTION = 'Нотификация пользователей'.freeze

  def process
    return unless pending?

    payable_entity.notify(params)
  end

  def redirect_path
    "/orders/#{payable_entity.id}?notified=#{success?}"
  end

  def build_megakassa_params(suggested_price)
    {
      shop_id: ENV['MEGAKASSA_SHOP_ID'],
      price: suggested_price.to_f,
      description: DEFAULT_DESCRIPTION,
      order_id: id,
      signature: generate_signature(
        [ENV['MEGAKASSA_SHOP_ID'], DEFAULT_AMOUNT, ENV['MEGAKASSA_DEFAULT_CURRENCY'],
         DEFAULT_DESCRIPTION, id, '', '', ENV['MEGAKASSA_DEBUG'], ENV['MEGAKASSA_SIGNATURE']],
        false
      )
    }
  end
end
