class ServiceOffer < Offer
  validates :price, presence: true
  validates :exchange_item, absence: true
end
