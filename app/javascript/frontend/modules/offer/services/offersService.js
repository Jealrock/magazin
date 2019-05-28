import { axiosInstance } from '@frontend/core/services/axios';

class OffersService {
  async postOffer(params) {
    return axiosInstance
      .post('/offers', this.buildOffer(params))
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async getOffer(offer_id) {
    return axiosInstance
      .get(`/offers/${offer_id}`)
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  buildOffer(params) {
    let builtOffer = params;
    if(params.type === "FreeOffer") {
      builtOffer.price = null;
      builtOffer.exchange_item = null;
    }
    else if (params.type === "ExchangeOffer")
      builtOffer.price = null;
    else if (params.type === "CashOffer")
      builtOffer.exchange_item = null;
    return builtOffer;
  }

  buildErrorMessage(error) {
    const errors_array = error.response.data && error.response.data.errors;
    if (!errors_array) return 'Unknown error';

    return (errors_array.full_messages && errors_array.full_messages.join("<br>")) ||
      Object.entries(errors_array).map(arr => arr.flat().join(' ')).join("<br>") ||
      errors_array.join("<br>")
  }
}

const offersService = new OffersService();
export { offersService };
