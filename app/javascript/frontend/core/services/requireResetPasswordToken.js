import { axiosInstance } from '@frontend/core/services/axios'

const requireResetPasswordToken = async function(to, from, next) {
  next();
  await axiosInstance.get('/password_resets/' + to.params.token)
    .then(response => { return next() })
    .catch(error => { return next('/sign') })
}

export default requireResetPasswordToken;
