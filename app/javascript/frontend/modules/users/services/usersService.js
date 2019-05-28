import { axiosInstance } from '@frontend/core/services/axios';

class UsersService {
  async update(params) {
    let formData = new FormData();
    Object.keys(params).forEach(key => formData.append(key, params[key]));

    return axiosInstance
      .patch(`/users/${params.id}`, formData, { headers: { 'Content-Type': 'multipart/form-data' }})
      .then(resp => resp.data.data.attributes)
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  buildErrorMessage(error) {
    const errors_array = error.response.data && error.response.data.errors;
    if (!errors_array) return 'Unknown error';

    return (errors_array.full_messages && errors_array.full_messages.join("\n")) ||
            errors_array.join("\n");
  }
}

const usersService = new UsersService();
export default usersService;
