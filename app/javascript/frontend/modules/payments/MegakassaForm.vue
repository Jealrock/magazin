<template>
  <form method="post" action="https://megakassa.ru/merchant/" v-on:submit="updatePayment" accept-charset="UTF-8">
    <input type="hidden" name="shop_id" :value="shopId" />
    <input type="hidden" name="amount" :value="price" />
    <input type="hidden" name="currency" value="RUB" />
    <input type="hidden" name="description" :value="description" />
    <input type="hidden" name="order_id" :value="orderId" />
    <input type="hidden" name="method_id" value="" />
    <input type="hidden" name="client_email" value="" />
    <input type="hidden" name="debug" :value="megakassaDebug" />
    <input type="hidden" name="signature" :value="signature" />
    <input type="hidden" name="language" value="ru" />
    <slot name="submitBtn"></slot>
  </form>
</template>

<script>
import { paymentsService } from '@frontend/modules/payments/services/paymentsService';

import configs from '@/packs/configs';

export default {
  props: {
    shopId: {type: String, required: true},
    price: {type: Number, required: true},
    description: {type: String},
    orderId: {type: Number, required: true},
    signature: {type: String, required: true},

    params: {type: Object}
  },

  data: () => ({
    megakassaDebug: configs.megakassaDebug
  }),

  methods: {
    updatePayment() {
      this.$emit('submitted', true);

      paymentsService
        .update(this.orderId, { params: this.params })
        .then(() => { console.log('success') });
    }
  }
}
</script>
