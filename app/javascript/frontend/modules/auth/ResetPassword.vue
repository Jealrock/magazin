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
              <v-alert
                :value="notice"
                type="success"
                class="mx-0 mb-3"
                outline
              >
                <div v-html="notice" />
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
                  <p class="grey--text body-2 font-weight-regular mb-5">
                    Мы отправим вам дальнейшие инструкции
                  </p>
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
                        Отправить
                      </v-btn>
                    </v-flex>
                    <v-flex
                      xs12
                      mt-4
                    >
                      <router-link
                        to="/sign_in"
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
import { mapActions } from 'vuex';

export default {
  $_veeValidate: {
    validator: 'new',
  },

  data: () => ({
    valid: true,
    email: '',
    error: null,
    notice: null,
  }),

  methods: {
    ...mapActions(['resetPassword']),

    async submit() {
      await this.$validator.validateAll();
      if (this.valid) {
        this.resetPassword({ email: this.email })
          .then((response) => {
            this.notice = 'Email with password reset instructions had been sent';
            this.error = null;
          })
          .catch((error) => {
            this.notice = null;
            this.error = error;
          });
      }
    },
  },
};
</script>
