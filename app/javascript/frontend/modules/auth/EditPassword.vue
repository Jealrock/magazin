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
            Новый пароль
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
                    ref="password"
                    v-model="password"
                    v-validate="'required|min:8'"
                    label="пароль"
                    data-vv-name="password"
                    :error-messages="errors.collect('password')"
                    :append-icon="isPasswordVisible ? 'visibility_off' : 'visibility'"
                    :type="isPasswordVisible ? 'text' : 'password'"
                    required
                    @click:append="() => (isPasswordVisible = !isPasswordVisible)"
                    @keyup.enter="submit"
                  />
                  <v-text-field
                    v-model="password_confirmation"
                    v-validate="'required|confirmed:password'"
                    label="пароль ещё раз"
                    data-vv-name="password_confirmation"
                    data-vv-as="password"
                    :error-messages="errors.collect('password_confirmation')"
                    :append-icon="isPasswordConfirmationVisible ? 'visibility_off' : 'visibility'"
                    :type="isPasswordConfirmationVisible ? 'text' : 'password'"
                    class="mb-5"
                    required
                    @click:append="() => (isPasswordConfirmationVisible = !isPasswordConfirmationVisible)"
                    @keyup.enter="submit"
                  />
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
                        :class=" {
                          'info' : valid,
                          disabled: !valid
                        } "
                        depressed
                        block
                        large
                        @click="submit"
                      >
                        Сохранить
                      </v-btn>
                    </v-flex>
                    <v-flex
                      xs12
                      mt-4
                    >
                      <router-link
                        to="/sign"
                        class="custom-black--text d-block text-xs-center"
                      >
                        Войти
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
    valid: false,
    password: '',
    password_confirmation: '',
    isPasswordVisible: false,
    isPasswordConfirmationVisible: false,
    error: null,
  }),

  computed: {
    ...mapState({
      beforeAuthRoute: state => state.routes.beforeAuthRoute,
    }),
  },

  created: function () {
    this.setAuthData(this.$route.query);
  },

  methods: {
    ...mapMutations(['setBeforeAuthRoute', 'setCurrentUser', 'setAuthData']),

    async submit() {
      await this.$validator.validateAll();
      if (!this.valid) return;
    
      console.log(this.$route);
      authService.updatePassword({
        password: this.password,
        password_confirmation: this.password_confirmation
      })
      .then(response => {
        this.setAuthData(response.headers);
        this.setCurrentUser(response.data.data);

        if (!this.beforeAuthRoute) {
          this.$router.push('/');
          return;
        }
        this.$router.push(this.beforeAuthRoute);
        this.setBeforeAuthRoute(null);
      })
      .catch(error => this.error = error);
    },
  },
};
</script>
