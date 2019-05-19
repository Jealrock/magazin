<template>
  <div id="sign-form-container">
    <v-toolbar color="white" class="v-toolbar--padded">
      <v-toolbar-title><h1>Sign up</h1></v-toolbar-title>
      </v-toolbar-items>
    </v-toolbar>
    <v-card>
      <v-card-text>
        <v-alert :value="error" type="error" class="mx-0 mb-3" outline><div v-html="error"/></v-alert>
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
              <v-text-field
                label="Enter your password"
                v-model="password"
                data-vv-name="password"
                v-validate="'required|min:8'"
                :error-messages="errors.collect('password')"
                :append-icon="isPasswordVisible ? 'visibility_off' : 'visibility'"
                :type="isPasswordVisible ? 'text' : 'password'"
                ref="password"
                class="password-field"
                required
                @click:append="() => (isPasswordVisible = !isPasswordVisible)"
                @keyup.enter="submit"
              ></v-text-field>
              <v-text-field
                label="Repeat password"
                v-model="password_confirmation"
                data-vv-name="password_confirmation"
                data-vv-as="password"
                v-validate="'required|confirmed:password'"
                :error-messages="errors.collect('password_confirmation')"
                :append-icon="isPasswordVisible ? 'visibility_off' : 'visibility'"
                :type="isPasswordVisible ? 'text' : 'password'"
                class="password-field"
                required
                @click:append="() => (isPasswordVisible = !isPasswordVisible)"
                @keyup.enter="submit"
              ></v-text-field>

              <v-layout
                align-content-end
                align-end
                justify-space-between>
                  <router-link
                    to="/sign_in"
                    class="custom-black--text"
                  >Sign in</router-link>
                  <v-btn 
                    @click="submit"
                    :class=" { 'blue darken-4 white--text' : valid, disabled: !valid }"
                    style="margin-bottom: 0px;"
                    depressed
                    round
                    >sign up</v-btn>
              </v-layout>
            </v-form>
        </div>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import { mapMutations, mapState } from 'vuex'
import { authService } from '@frontend/core/services/authService';

export default {
  $_veeValidate: {
    validator: 'new'
  },

  data: () => ({
    valid: true,
    email: '',
    password: '',
    password_confirmation: '',
    isPasswordVisible: false,
    error: null 
  }),

  computed: {
    ...mapState({
      beforeAuthRoute: state => state.routes.beforeAuthRoute
    })
  },

  methods: {
    ...mapMutations(['setBeforeAuthRoute', 'setCurrentUser', 'setAuthData']),

    async submit () {
      await this.$validator.validateAll();
      if (!this.valid) return;

      authService.signup({ email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => {
          this.setAuthData(response.headers);
          this.setCurrentUser(response.data.data);

          if (!this.beforeAuthRoute) {
            this.$router.push('/');
            return;
          }
          this.$router.push(this.beforeAuthRoute)
          this.setBeforeAuthRoute(null)
        })
        .catch(error => {
          this.error = error
        });
    }
  }
}
</script>

<style scoped>
  .v-text-field.password-field {
    margin-bottom: 74px;
  }
</style>

