import userAuthService from './userAuthService';

const alreadyAuth = async function(to, from, next) {
  try {
    if (userAuthService.currentUser) {
      return next("/dashboard");
    } else {
      const token = userAuthService.getToken();
      if (token) {
        let user = await userAuthService.fetchUser();
        if (user) {
          return next("/dashboard")
        } else {
          userAuthService.logout();
        }
      }
      return next();
    }
  } catch (error) {
    console.log(error);
    return next();
  }
};

export default alreadyAuth;
