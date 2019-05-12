import axios from 'axios'

export default class ApiService {
    constructor(resourceName) {
      this.resourceName = resourceName;
      this.basePath = resourceName;
    }

    async get(params = {}) {
      const headers = await this.requestHeaders();
      return await axios.get(this.basePath, {
          params: params,
          headers: headers
        })
        .then(res => {
          return res.data;
        })
        .catch(e => {
          console.log(e)
          return null
        });
    }

    async post(params = {}) {
      const headers = await this.requestHeaders();
      const res = await axios.post(this.basePath, params, {
            headers: headers
          })
        .then(res => {
          return res.data;
        })
        .catch(e => {
          console.log(e)
          return null
        });
      return res;
    }

    async requestHeaders() {
      const token = localStorage.auth_key;
      return {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
      }
    }
}
