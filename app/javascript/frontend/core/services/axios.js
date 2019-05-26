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
    if (!isRefreshable(error)) {
      store.commit('clearUsersState')
      router.push('/sign')
      return Promise.reject(error)
    }

    // In case 401 is caused by expired access header - we'll do refresh request
    return axiosInstance.post('/refresh')
      .then(response => {
        store.commit('setAccessToken', response.data.access);
        return axiosInstance.get('/me')
          .then(meResponse => {
            store.commit('setCurrentUser', { currentUser: meResponse.data })
            // And after successful refresh - repeat the original request
            let retryConfig = error.response.config
            retryConfig.url = retryConfig.url.replace(API_URL, '')
            return axiosInstance.request(retryConfig)
          })
      }).catch(error => {
        store.commit('clearUsersState');
        router.push('/sign');
        return Promise.reject(error);
      })
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

function isRefreshable(error) {
  return store.state.users.authData.accessToken &&
         url.parse(error.request.responseURL).pathname != '/api/v1/refresh'
}

export { axiosInstance }

