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
    'Authorization': store.state.users.access_token
  }
  return config
})

axiosInstance.interceptors.response.use(null, error => {
  if (isAuthError(error)) {
    if (!isRefreshable(error)) {
      store.commit('clearCurrentUser')
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
        store.commit('clearCurrentUser')
        router.push('/sign')
        return Promise.reject(error)
      })
  } else {
    return Promise.reject(error)
  }
})

function isAuthError(error) {
  return error.response && error.response.config && error.response.status === 401 &&
         url.parse(error.request.responseURL).pathname != '/api/v1/password_resets'
}

function isRefreshable(error) {
  return store.state.users.access_token &&
         url.parse(error.request.responseURL).pathname != '/api/v1/refresh'
}

export { axiosInstance }

