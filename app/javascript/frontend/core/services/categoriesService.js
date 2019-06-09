import { axiosInstance } from '@frontend/core/services/axios';

class CategoriesService {
  async all(input) {
    return axiosInstance.get('/categories').then(resp => resp.data.data)
  }
}

const categoriesService = new CategoriesService();
export default categoriesService;
