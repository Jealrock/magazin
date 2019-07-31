<template>
  <form method="get" action="https://free-kassa.ru/merchant/cash.php" v-on:submit="updatePayment" accept-charset="UTF-8">
    <input type="hidden" name="m" :value="shopId" />
    <input type="hidden" name="oa" :value="price" />
    <input type="hidden" name="o" :value="orderId" />
    <input type="hidden" name="s" :value="signature" />
    <slot name="submitBtn"></slot>
  </form>
</template>

<script>
import { paymentsService } from '@frontend/modules/payments/services/paymentsService';

export default  {
  props: {
    shopId: {type: String, required: true},
    price: {type: Number, required: true},
    orderId: {type: Number, required: true},
    signature: {type: String, required: true},
    email: {type: String, required: true},

    params: {type: Object}
  },

  methods: {
    updatePayment() {
      this.$emit('submitted', true)

      paymentsService
        .update(this.orderId, { params: this.params })
        .then(() => { console.log('success') });
    },
  }
}
</script>
