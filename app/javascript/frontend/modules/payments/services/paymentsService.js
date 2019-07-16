import { axiosInstance } from '@frontend/core/services/axios';

class PaymentsService {
  async create(params) {
    return axiosInstance
      .post(`/payments`, params)
      .then(resp => resp.data)
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async update(paymentId, params) {
    return axiosInstance
      .patch(`/payments/${paymentId}`, params)
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

const paymentsService = new PaymentsService();
export { paymentsService }
