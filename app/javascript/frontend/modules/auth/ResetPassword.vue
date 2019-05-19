<template>
  <div id="sign-form-container">
    <v-toolbar color="white" class="v-toolbar--padded">
      <v-toolbar-title><h1>Reset password</h1></v-toolbar-title>
      </v-toolbar-items>
    </v-toolbar>
    <v-card>
      <v-card-text>
        <v-alert :value="error" type="error" class="mx-0 mb-3" outline><div v-html="error"/></v-alert>
        <v-alert :value="notice" type="success" class="mx-0 mb-3" outline><div v-html="notice"/></v-alert>
        <div>
            <v-form v-model="valid" ref="form">
              <v-text-field
                label="Enter your e-mail address"
                v-model="email"
                type="email"
                data-vv-name="email"
                v-validate="'required|email'"
                :error-messages="errors.collect('email')"
                required
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
                    >Send instructions</v-btn>
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
    valid: true, 
    email: '',
    error: null,
    notice: null
  }),

  methods: {
    ...mapActions(['resetPassword']),

    async submit () {
      await this.$validator.validateAll()
      if (this.valid) {
        this.resetPassword({ email: this.email })
          .then(response => {
            this.notice = "Email with password reset instructions had been sent"
            this.error = null
          })
          .catch(error => {
            this.notice = null
            this.error = error
          });
      }
    }
  }
}
</script>

<style scoped>
  .v-text-field.theme--light {
    margin-bottom: 74px;
  }
</style>

