self.addEventListener('push', (event) => {
  var eventPayload = JSON.parse(event.data.text());
  var notificationOptions = {
    body: eventPayload.body,
    icon: eventPayload.icon,
    data: {
      offerId: eventPayload.offer_id
    }
  };

  event.waitUntil(
    self.registration.showNotification(eventPayload.title, notificationOptions)
  );
});

self.addEventListener('notificationclick', function(e) {
  var notification = e.notification;
  var offerId = notification.data.offerId;
  var action = e.action;

  if (action === 'close') {
    notification.close();
  } else {
    clients.openWindow('https://magazin-staging.herokuapp.com/offer/' + offerId);
    notification.close();
  }
});

