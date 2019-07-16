<template>
  <form method="post" action="https://megakassa.ru/merchant/" v-on:submit="updatePayment" accept-charset="UTF-8" target="_blank">
    <input type="hidden" name="shop_id" :value="shopId" />
    <input type="hidden" name="amount" :value="price" />
    <input type="hidden" name="currency" value="RUB" />
    <input type="hidden" name="description" :value="description" />
    <input type="hidden" name="order_id" :value="orderId" />
    <input type="hidden" name="method_id" value="" />
    <input type="hidden" name="client_email" value="" />
    <input type="hidden" name="debug" value="" />
    <input type="hidden" name="signature" :value="signature" />
    <input type="hidden" name="language" value="ru" />
    <slot name="submitBtn"></slot>
  </form>
</template>

<script>
export default {
  props: {
    shopId: {type: String, required: true},
    price: {type: Number, required: true},
    description: {type: String},
    orderId: {type: Number, required: true},
    signature: {type: String, required: true}
  },

  methods: {
    updatePayment() {
      paymentsService.create({
        'payable_entity_id': this.offer.id,
        'payable_entity_type': 'Offer',
        'type': 'Notification'
      }).then(paymentData => {
        this.$refs.notificationDialog.showMainDialog(paymentData);
      });
    }
  }
}
</script>
