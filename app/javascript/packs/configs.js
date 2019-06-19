export default {
  isProduction: process.env.NODE_ENV === 'production',
  WebPushVapidPublicKey: process.env.VUE_APP_VAPID_PUBLIC_KEY,
  fcmServerKey: process.env.VUE_APP_FCM_SERVER_KEY,
  webSocketUrl: process.env.VUE_APP_WEB_SOCKET_URL,
};
