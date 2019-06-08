
class PermissionsManager {
  async requestNotifications() {
    if (!('Notification' in window)) return false;
    if (Notification.permission === 'granted') return false;

    return await Notification.requestPermission().then((result) => {
      return result === 'granted';
    });
  }
}

export default new PermissionsManager();
