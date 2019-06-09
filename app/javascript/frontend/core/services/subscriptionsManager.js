import { axiosInstance } from "./axios";
import configs from "@/packs/configs";

const urlBase64ToUint8Array = function (base64String) {
  const padding = '='.repeat((4 - base64String.length % 4) % 4);
  const base64 = (base64String + padding)
    .replace(/-/g, '+')
    .replace(/_/g, '/');

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}

const convertedVapidKey = urlBase64ToUint8Array(configs.WebPushVapidPublicKey);

class SubscriptionsManager {
  constructor() {
    this.convertedVapidKey = convertedVapidKey;
  }

  async createSubscription() {
    try {
      const registration = await navigator.serviceWorker.ready;
      const currentSubscription = await registration.pushManager.getSubscription();
      if (currentSubscription) return;

      const registrationInfo = await registration.pushManager.subscribe({
        userVisibleOnly: true
      });
      const resp = await axiosInstance.post('/subscriptions', registrationInfo);

      return resp;
    } catch (error) {
      console.log('[Subscription] ', error);
    }
  }
}

export default new SubscriptionsManager();
