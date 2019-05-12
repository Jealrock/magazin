import Sign from '@frontend/modules/sign/Sign';
import alreadyAuthorized from '@frontend/core/services/alreadyAuthorized'

export const SIGN_ROUTER = {
  path: '/sign',
  component: Sign,
  beforeEnter: alreadyAuthorized
};
