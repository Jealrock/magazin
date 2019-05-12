import ApiService from './ApiService'
class UserAuthService {
  constructor() {
    this.currentUser = null;
  }

  async login(email = null, password = null) {
    if (email || password) {
      return await this.authorizeUser(email, password);
    } else {
      return await this.fetchUser();
    }
  }

  logout() {
    this.currentUser = null;
    localStorage.removeItem('auth_key');
  }

  async fetchUser(email = null, password = null) {
    const token = this.getToken();
    if (token) {
      let user = await new ApiService('users/me').get();
      this.setUser(user);
      return user;
    }

    throw 'User is not authenticated';
  }

  async authorizeUser(email, password) {
    let res = await new ApiService('sign_in').post({auth: {
      email: email,
      password: password
    }});
    if (res) {
      const user = this.parseJwt(res.jwt);
      if (user) {
        this.setUser(user);
        this.setToken(res.jwt);
        return user;
      }
    }

    throw 'User is not authenticated';
  }

  setUser(user) {
    this.currentUser = user;
  }

  setToken(token) {
    localStorage.auth_key = token;
  }

  getToken() {
    return localStorage.auth_key;
  }

  parseJwt(token) {
    let base64Url = token.split('.')[1];
    let base64 = base64Url.replace('-', '+').replace('_', '/');
    let user = JSON.parse(window.atob(base64));
    user.full_name = decodeURIComponent(escape(user.full_name));
    return user;
  }
}
const userAuthService = new UserAuthService();
export default userAuthService;
