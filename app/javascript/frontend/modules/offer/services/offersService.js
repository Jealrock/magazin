import { axiosInstance } from '@frontend/core/services/axios';

const DEFAULT_PER_PAGE = 25;

class OffersService {
  async all(params) {
    return axiosInstance
      .get('/offers', { params: { ...params, per_page: DEFAULT_PER_PAGE } })
      .then(resp => resp.data)
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async create(params) {
    return axiosInstance
      .post('/offers', this.buildOffer(params))
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async get(offer_id) {
    return axiosInstance
      .get(`/offers/${offer_id}`)
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async close(offer_id) {
    return axiosInstance
      .post(`/offers/${offer_id}/close`)
      .then(resp => resp.data.data.attributes)
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
    if (error.response.data && error.response.data.error_messsage) return errors.message;

    const errors_array = error.response.data && error.response.data.errors;
    if (!errors_array) return 'Unknown error';

    return (errors_array.full_messages && errors_array.full_messages.join("<br>")) ||
      Object.entries(errors_array).map(arr => arr.flat().join(' ')).join("<br>") ||
      errors_array.join("<br>")
  }
}

const offersService = new OffersService();
export { offersService, DEFAULT_PER_PAGE };
