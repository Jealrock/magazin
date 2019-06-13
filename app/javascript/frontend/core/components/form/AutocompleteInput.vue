<template>
  <v-autocomplete
    v-model="model"
    :items="items"
    :label="label"
    :placeholder="placeholder"
    :loading="!loaded"
    :search-input.sync="search"
    :hide-details="hideDetails"
    no-filter
    hide-no-data
    required
  />
</template>

<script>

export default {
  props: {
    value: { type: String, default: '' },
    items: { type: Array, default: [] },
    label: { type: String, default: '' },
    placeholder: { type: String, default: '' },
    loaded: { type: Boolean, default: true },
    hideDetails: { type: Boolean, default: false }
  },

  data: () => ({
    timeout: null, 
    model: '',
    search: null,
  }),

  created () {
    // select initial value (useful during edit)
    if (!this.value || this.value.length == 0) return;

    this.model = this.value;
    this.search = this.value;
  },

  watch: {
    search (val) {
      if (this.timeout !== null)  clearTimeout(this.timeout);
      if (!val || val.length == 0) {
        this.model = '';
        return;
      }
      if (!val || val.length < 3 || val == this.model) return;

      let that = this; 
      // set timeout to not send request on each keypress
      this.timeout = setTimeout(function () {
        that.$emit('update', val);
      }, 1000);
    },

    model (val) {
      this.$emit('change', val);
    }
  }
};
</script>
