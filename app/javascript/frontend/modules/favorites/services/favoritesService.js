import { axiosInstance } from '@frontend/core/services/axios';

class FavoritesService {
  get() {
    return axiosInstance
      .get('/favorites')
      .then((response) => response)
      .catch((error) => {
        throw new Error(error);
      });
  }

  post(params) {
    return axiosInstance
      .post('/favorites', params)
      .then((response) => response)
      .catch((error) => {
        throw new Error(error);
      });
  }

  delete(offerId) {
    return axiosInstance
      .delete(`/favorites/${offerId}`)
      .then((response) => {
        console.log(response);
      })
      .catch((error) => {
        throw new Error(error);
      });
  }
}

const favoritesService = new FavoritesService();
export { favoritesService }
