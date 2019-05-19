<template>
    <div id="sign-form-container">
      <v-toolbar color="white" class="v-toolbar--padded">
        <v-toolbar-title><h1>Change password</h1></v-toolbar-title>
        </v-toolbar-items>
      </v-toolbar>
      <v-card>
        <v-card-text>
          <v-alert :value="error" type="error" class="mx-0 mb-3" outline><div v-html="error"/></v-alert>
          <div>
              <v-form v-model="valid" ref="form">
                <v-text-field
                  label="Enter new password"
                  v-model="password"
                  data-vv-name="password"
                  v-validate="'required|min:8'"
                  :error-messages="errors.collect('password')"
                  :append-icon="isPasswordVisible ? 'visibility_off' : 'visibility'"
                  :type="isPasswordVisible ? 'text' : 'password'"
                  ref="password"
                  required
                  @click:append="() => (isPasswordVisible = !isPasswordVisible)"
                  @keyup.enter="submit"
                ></v-text-field>
                <v-text-field
                  label="Confirm new password" v-model="password_confirmation"
                  data-vv-name="password_confirmation"
                  data-vv-as="password"
                  v-validate="'required|confirmed:password'"
                  :error-messages="errors.collect('password_confirmation')"
                  :append-icon="isPasswordConfirmationVisible ? 'visibility_off' : 'visibility'"
                  :type="isPasswordConfirmationVisible ? 'text' : 'password'"
                  class="password-confirmation-field"
                  required
                  @click:append="() => (isPasswordConfirmationVisible = !isPasswordConfirmationVisible)"
                  @keyup.enter="submit"
                ></v-text-field>
                <v-layout
                  align-content-end
                  align-end
                  justify-space-between>
                    <router-link
                      to="/sign"
                      class="custom-black--text"
                    >Sign in</router-link>
                    <v-btn 
                      @click="submit"
                      :class=" { 'blue darken-4 white--text' : valid, disabled: !valid }"
                      style="margin-bottom: 0px;"
                      depressed
                      round
                      >Save</v-btn>
                </v-layout>
              </v-form>
          </div>
        </v-card-text>
      </v-card>
    </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  $_veeValidate: {
      validator: 'new'
  },

  data: () => ({
    valid: false, 
    password: '',
    password_confirmation: '',
    isPasswordVisible: false,
    isPasswordConfirmationVisible: false,
    error: null
  }),

  methods: {
    ...mapActions(['editPassword']),
    
    async submit() {
      await this.$validator.validateAll();
      if (this.valid) {
        this.editPassword({ 
          token: this.$route.params.token,
          password: this.password,
          password_confirmation: this.password_confirmation })
          .then(response => this.$router.push('/'))
          .catch(error => this.error = error);
      }
    },
  }
}
</script>

<style scoped>
  .v-text-field.password-confirmation-field {
    margin-bottom: 74px;
  }
</style>

