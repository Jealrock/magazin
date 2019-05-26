import axios from 'axios'
import store from '@/store/store'
import router from '@frontend/router'
import url from 'url'

const API_URL = '/api/v1'

const axiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
  }
})

axiosInstance.interceptors.request.use(config => {
  config.headers = {
    ...config.headers,
    'token-type': 'Bearer',
    'access-token': store.state.users.authData.accessToken,
    'client': store.state.users.authData.client,
    'expiry': store.state.users.authData.expiry,
    'uid': store.state.users.authData.uid
  }
  return config
})

axiosInstance.interceptors.response.use(null, error => {
  if (isAuthError(error)) {
    store.commit('clearUsersState')
    router.push('/sign')
    return Promise.reject(error)
  } else {
    return Promise.reject(error);
  }
})

function isAuthError(error) {
  const current_path = url.parse(error.request.responseURL).pathname
  return error.response && error.response.config && error.response.status === 401 &&
          current_path != '/api/v1/auth/password' &&
          current_path != '/api/v1/auth/sign_in'
}

export { axiosInstance }
