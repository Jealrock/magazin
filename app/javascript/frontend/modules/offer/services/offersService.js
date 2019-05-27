import { axiosInstance } from '@frontend/core/services/axios';

class OffersService {
  async postOffer(params) {
    return axiosInstance
      .post('/offers', this.buildOffer(params))
      .catch(error => { throw new Error(error) });
  }

  async getOffer(offer_id) {
    return axiosInstance
      .get(`/offers/${offer_id}`)
      .catch(error => { throw new Error(error) });
  }

  buildOffer(params) {
    let builtOffer = params;
    if(params.type === "FreeOffer") {
      builtOffer.price = '';
      builtOffer.exchange_item = '';
    }
    else if (params.type === "ExchangeOffer")
      builtOffer.price = '';
    else if (params.type === "CashOffer")
      builtOffer.exchange_item = '';
    return builtOffer;
  }
}

const offersService = new OffersService();
export { offersService };
