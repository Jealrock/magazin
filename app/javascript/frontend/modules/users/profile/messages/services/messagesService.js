import { axiosInstance } from '@frontend/core/services/axios';

class MessagesService {
  all(with_user_id) {
    return axiosInstance
      .get('/messages', {params: { with_user_id } })
      .then((response) => response.data.data)
      .catch((error) => {
        throw new Error(error);
      });
  }

  create(params) {
    return axiosInstance
      .post('/messages', params)
      .then((response) => response.data.data)
      .catch((error) => {
        throw new Error(error);
      });
  }
}

const messagesService = new MessagesService();
export { messagesService };
