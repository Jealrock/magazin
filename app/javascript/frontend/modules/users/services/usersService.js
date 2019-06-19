import { axiosInstance } from '@frontend/core/services/axios';

const DEFAULT_PER_PAGE = 24;

class UsersService {
  async update(params) {
    return axiosInstance
      .patch(`/users/${params.id}`, this.buildUser(params), { headers: { 'Content-Type': 'multipart/form-data' }})
      .then(resp => resp.data.data.attributes)
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async find(userId) {
    return axiosInstance
      .get(`/users/${userId}`)
      .then((resp) => resp.data.data)
      .catch(error => { throw new Error(error) });
  }

  async getOffers(params) {
    return axiosInstance
      .get('/users/offers', {params: {...params, per_page: DEFAULT_PER_PAGE}})
      .then((resp) => resp.data)
      .catch(error => { throw new Error(error) });
  }

  buildUser(params) {
    const formData = new FormData();
    Object.keys(params).forEach(key => {
      return formData.append(key, params[key] || '');
    });
    return formData;
  }

  buildErrorMessage(error) {
    const errors_array = error.response.data && error.response.data.errors;
    if (!errors_array) return 'Unknown error';

    return (errors_array.full_messages && errors_array.full_messages.join("\n")) ||
            errors_array.join("\n");
  }
}

const usersService = new UsersService();
export { DEFAULT_PER_PAGE, usersService }
