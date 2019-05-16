import SignIn from '@frontend/modules/auth/SignIn';
import SignUp from '@frontend/modules/auth/SignUp';
import ResetPassword from '@frontend/modules/auth/ResetPassword';
import EditPassword from '@frontend/modules/auth/EditPassword';
import requireUnauthorized from '@frontend/core/services/requireUnauthorized'

export const SIGN_IN_ROUTER = {
  path: '/sign_in',
  component: SignIn,
  beforeEnter: requireUnauthorized
};

export const SIGN_UP_ROUTER = {
  path: '/sign_up',
  component: SignUp,
  beforeEnter: requireUnauthorized
};

export const RESET_PASSWORD_ROUTER = {
  path: '/reset_password',
  component: ResetPassword,
  beforeEnter: requireUnauthorized
};

export const EDIT_PASSWORD_ROUTER = {
  path: '/edit_password',
  component: EditPassword,
  beforeEnter: requireUnauthorized
};
