module OfferMailerHelper
  def offer_value(offer)
    return "Обмен на #{offer.exchange_item}" if offer.type == 'ExchangeOffer'
    return 'Бесплатно' if offer.type == 'FreeOffer'

    "#{offer.price} руб."
  end
end
