import userAuthService from './userAuthService';

const requireAuth = async function(to, from, next) {
  try {
    if (userAuthService.currentUser) {
      if (userAuthService.currentUser.disabled) {
        return next("/sign");
      } else {
        return next();
      }
    } else {
      const token = userAuthService.getToken();
      if (token) {
        let user = await userAuthService.fetchUser();
        if (user) {
          return next()
        } else {
          userAuthService.logout();
        }
      }
      return next("/sign");
    }
  } catch (error) {
    console.log(error);
    return next("/sign");
  }
};

export default requireAuth;
