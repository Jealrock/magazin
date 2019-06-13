class ExchangeOffer < Offer
  validates :price, absence: true
end
