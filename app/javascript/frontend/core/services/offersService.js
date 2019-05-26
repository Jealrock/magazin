import { axiosInstance } from '@frontend/core/services/axios';

class OffersService {
  async postOffer({ title, description }) {
    return axiosInstance
      .post('/offers', { title, description })
      .catch(error => { throw new Error(error) });
  }
}

const offersService = new OffersService();
export { offersService };
