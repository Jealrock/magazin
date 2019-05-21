<template>
  <div id="sign-form-container">
    <v-container>
      <v-layout
        row
        wrap
        justify-center
      >
        <v-flex
          xs12
          sm6
          md5
          class="elevation-2"
        >
          <h1 class="text-xs-center mt-3">
            Вход
          </h1>
          <v-card class="elevation-0">
            <v-card-text>
              <v-alert
                :value="error"
                type="error"
                class="mx-0 mb-3"
                outline
              >
                <div v-html="error" />
              </v-alert>
              <div>
                <v-form
                  ref="form"
                  v-model="valid"
                >
                  <v-text-field
                    v-model="email"
                    v-validate="'required|email'"
                    label="e-mail"
                    type="email"
                    data-vv-name="email"
                    :error-messages="errors.collect('email')"
                    required
                    @keyup.enter="submit"
                  />
                  <v-text-field
                    v-model="password"
                    v-validate="'required|min:8'"
                    label="пароль"
                    data-vv-name="password"
                    :error-messages="errors.collect('password')"
                    :append-icon="isPasswordVisible ? 'visibility_off' : 'visibility'"
                    :type="isPasswordVisible ? 'text' : 'password'"
                    class="password-field"
                    required
                    @click:append="() => (isPasswordVisible = !isPasswordVisible)"
                    @keyup.enter="submit"
                  />
                  <v-layout
                    row
                    wrap
                    class="mb-5"
                    justify-end
                  >
                    <router-link
                      to="/reset_password"
                      class="custom-black--text"
                    >
                      Забыли пароль?
                    </router-link>
                  </v-layout>
                  <v-layout
                    row
                    wrap
                  >
                    <v-flex
                      :class=" {
                        'xs6 offset-xs3' : $vuetify.breakpoint.smAndUp,
                        'xs12' : $vuetify.breakpoint.xsOnly
                      } "
                    >
                      <v-btn
                        class="ma-0"
                        :class=" { 'info' : valid, disabled: !valid }"
                        depressed
                        block
                        large
                        @click="submit"
                      >
                        войти
                      </v-btn>
                    </v-flex>
                    <v-flex
                      xs12
                      mt-4
                    >
                      <router-link
                        to="/sign_up"
                        class="custom-black--text d-block text-xs-center"
                      >
                        Регистрация
                      </router-link>
                    </v-flex>
                  </v-layout>
                </v-form>
              </div>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapMutations, mapState } from 'vuex';
import { authService } from '@frontend/core/services/authService';

export default {
  $_veeValidate: {
    validator: 'new',
  },

  data: () => ({
    valid: true,
    email: '',
    password: '',
    isPasswordVisible: false,
    error: null,
  }),

  computed: {
    ...mapState({
      beforeAuthRoute: state => state.routes.beforeAuthRoute,
    }),
  },

  methods: {
    ...mapMutations(['setBeforeAuthRoute', 'setCurrentUser', 'setAuthData']),

    async submit() {
      await this.$validator.validateAll();
      if (!this.valid) return;

      authService.signin({ email: this.email, password: this.password })
        .then((response) => {
          this.setAuthData(response.headers);
          this.setCurrentUser(response.data.data);

          if (!this.beforeAuthRoute) {
            this.$router.push('/');
            return;
          }
          this.$router.push(this.beforeAuthRoute);
          this.setBeforeAuthRoute(null);
        })
        .catch((error) => {
          this.error = error;
        });
    },
  },
};
</script>
