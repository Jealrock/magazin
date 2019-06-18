import { axiosInstance } from '@frontend/core/services/axios';

class MessageThreadsService {
  all(params = {}) {
    return axiosInstance
      .get('/message_threads', {params: params})
      .then((response) => response.data.data)
      .catch((error) => {
        throw new Error(error);
      });
  }
}

const messageThreadsService = new MessageThreadsService();
export { messageThreadsService };
