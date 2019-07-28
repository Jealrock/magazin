<template>
  <div @click="loadForm()">
    <slot name="submitBtn"></slot>
  </div>
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
    loadForm() {
      let form = new FK();

      this.$emit('submitted', true);

      paymentsService
        .update(this.orderId, { params: this.params })
        .then(() => { console.log('success') });

      form.loadWidget({
        merchant_id: this.shopId,
        amount: this.price,
        order_id: this.orderId,
        email: this.email,
        sign: this.signature,
        us_params: this.params, 
      });
    }
  }
}
</script>
