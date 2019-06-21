import { axiosInstance } from '@frontend/core/services/axios';

class CategorySubscriptionsService {
  all() {
    return axiosInstance
      .get('/category_subscriptions')
      .then((response) => response.data)
      .catch((error) => {
        throw new Error(error)
      })
  }

  create(params) {
    return axiosInstance
      .post('/category_subscriptions', params)
      .then((response) => response)
      .catch((error) => {
        throw new Error(error)
      })
  }

  destroy(categoryId) {
    return axiosInstance
      .delete(`/category_subscriptions/${categoryId}`)
      .then((response) => response)
      .catch((error) => {
        throw new Error(error);
      })
  }
}

const categorySubscriptionsService = new CategorySubscriptionsService();
export { categorySubscriptionsService }
