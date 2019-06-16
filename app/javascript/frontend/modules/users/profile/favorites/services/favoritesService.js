import { axiosInstance } from '@frontend/core/services/axios';

const DEFAULT_PER_PAGE = 24;

class FavoritesService {
  all(params) {
    return axiosInstance
      .get('/favorites', {params: params})
      .then((response) => response.data)
      .catch((error) => {
        throw new Error(error);
      });
  }

  create(params) {
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
      .then((response) => response)
      .catch((error) => {
        throw new Error(error);
      });
  }
}

const favoritesService = new FavoritesService();
export { DEFAULT_PER_PAGE, favoritesService }
