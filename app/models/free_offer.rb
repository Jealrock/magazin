class FreeOffer < Offer
  validates :price, absence: true
  validates :exchange_item, absence: true
end
