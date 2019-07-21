export default {
  isProduction: process.env.NODE_ENV === 'production',
  WebPushVapidPublicKey: process.env.VUE_APP_VAPID_PUBLIC_KEY,
  fcmServerKey: process.env.VUE_APP_FCM_SERVER_KEY,
  webSocketUrl: process.env.VUE_APP_WEB_SOCKET_URL,
  notificationAllPrice: parseFloat(process.env.VUE_APP_NOTIFICATION_ALL_PRICE),
  notificationTargetPrice: parseFloat(process.env.VUE_APP_NOTIFICATION_TARGET_PRICE),
  megakassaDebug: process.env.VUE_APP_MEGAKASSA_DEBUG,
};
