/* eslint-disable no-console */

import { register } from 'register-service-worker';

register('/service-worker.js', {
  error(error) {
    console.error('Error during service worker registration:', error);
  },
});
