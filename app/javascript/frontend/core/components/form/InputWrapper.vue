<template>
  <label class="input">
    <span class="input__label" v-if="label">{{label}}</span>
    <slot></slot>
    <span class="input__message" v-if="message" v-bind:title="message">{{message}}</span>
  </label>
</template>

<script>
export default {
  name: 'InputWrapper',
  props: {
    label: '',
    message: null
  }
};
</script>

<style scoped>
  .input {
    position: relative;
    display: block;
  }

  .input--error {
    input {
      border-color: #DF4040;
    }
  }

  .input__label {
    display: block;
    margin-bottom: 8px;
    font-size: 14px;
    color: #272727;
  }

  input {
    display: block;
    padding: 9px 12px 8px;
    color: #272727;
    border: 1px solid #C1C1C1;
    border-radius: 2px;
    &::placeholder {
      font-size: 16px;
      color: rgba(39, 39, 39, .6);
    }
    &:focus {
      border-color: #277EE8;
    }
  }

  .input__message {
    display: block;
    padding-top: 8px;
    font-size: 14px;
    color: #DF4040;
  }
</style>