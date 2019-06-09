self.addEventListener('push', (event) => {
  var eventPayload = JSON.parse(event.data.text());
  var notificationOptions = {
    body: eventPayload.body
  };

  event.waitUntil(
    self.registration.showNotification(eventPayload.title, notificationOptions)
  );
});
