module Api::V1::Offer
  class Index < ApplicationOperation
    step :model!
    step Policy::Pundit(OfferPolicy, :index?)
    failure :authorization_error!

    def model!(options, *)
      options['model'] = Offer.includes(:photos).opened
    end
  end
end
