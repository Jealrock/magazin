class ExchangeOffer < Offer
  validates :price, absence: true
  validates :exchange_item, presence: true
end
