import { axiosInstance } from '@frontend/core/services/axios';
import { EDIT_PASSWORD_ROUTER } from '@frontend/modules/auth/router';

class AuthService {
  async signin({ email, password }) {
    return axiosInstance
      .post('/auth/sign_in', { email, password })
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async signup({ email, password, password_confirmation }) {
    return axiosInstance
      .post('/auth', { email, password, password_confirmation })
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async signout() {
    return axiosInstance
      .delete('/auth/sign_out')
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async resetPassword({ email }) {
    return axiosInstance
      .post('/auth/password', { email, redirect_url: window.origin + EDIT_PASSWORD_ROUTER.path })
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  async updatePassword({ password, password_confirmation }) {
    return axiosInstance
      .patch('/auth/password', { password, password_confirmation })
      .catch(error => { throw this.buildErrorMessage(error) });
  }

  buildErrorMessage(error) {
    const errors_array = error.response.data && error.response.data.errors;
    if (!errors_array) return 'Unknown error';

    return (errors_array.full_messages && errors_array.full_messages.join("\n")) ||
            errors_array.join("\n");
  }
}

const authService = new AuthService();
export { authService };
