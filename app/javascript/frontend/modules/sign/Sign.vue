<template>
  <div class="sign">
    <div class="wrapper">
      <div class="sign__content">
        <div class="sign__box">
          <div class="sign__title">Login to Application</div>
          <form class="sign__form">
            <div class="sign__input">
              <InputWrapper
                label="Email">
                <input
                  v-model="email"
                  name="email"
                  type="email"
                  placeholder="ex.mirko@mail.com"/>
              </InputWrapper>
            </div>
            <div class="sign__input">
              <InputWrapper
                label="Password"
                v-bind:message="hasError ? errorMessage : ''"
                v-bind:class="{'input--error': hasError}">
                <input
                  v-model="password"
                  name="password"
                  type="password"
                  placeholder="●●●●●●●●"/>
              </InputWrapper>
            </div>
            <div class="sign__actions">
              <button class="sign__button" type="submit" @click.prevent="signIn">Login</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import InputWrapper from '@frontend/core/components/form/InputWrapper'
import userAuthService from '@frontend/core/services/userAuthService';

class AuthError {
  constructor() {
    this.unauthorized = false;
    this.disabled = false;
  }

  is_present() {
    return this.unauthorized || this.disabled;
  }

  clear() {
    this.unauthorized = false;
    this.disabled = false;
  }
}

export default {
  components: {
    InputWrapper
  },

  data: () => ({
    email: '',
    password: '',
    authError: AuthError
  }),

  computed: {
    errorMessage: function() {
      if (this.authError.unauthorized) {
        return 'The email or password isn\'t correct.';
      } else if (this.authError.disabled) {
        return 'Your account was disabled. Please, contact administrator for more information';
      } else {
        return '';
      }
    },
    hasError: function() {
      return this.authError.is_present();
    }
  },

  methods: {
    signIn: async function() {
      try {
        var res = await userAuthService.login(this.email, this.password);
        this.authError.clear();
        if ( res ) {
          if ( res.disabled ) {
            this.authError.disabled = true;
          } else {
            this.$router.push('/dashboard');
          }
        }
      } catch(error) {
        console.log(error);
        this.authError.unauthorized = true;
      }
    }
  },

  created(){
    this.authError = new AuthError();
  }
}
</script>

<style scoped>
  .sign__content {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100vh;
    height: auto !important;
    padding: 104px 0;
    box-sizing: border-box;
    @media (--tablet-viewport) {
      padding: 70px 0;
    }
  }

  .sign__box {
    max-width: 428px;
    width: 100%;
    border-radius: 6px;
    box-shadow: 0 1px 2px 0 rgba(0,0,0,0.15);
    overflow: hidden;
  }

  .sign__title {
    padding: 19px 18px 18px;
    font-size: 20px;
    color: #272727;
    text-align: center;
    background: #F8F8F8;
    border-bottom: 1px solid #EFEFEF;
  }

  .sign__form {
    padding: 36px 44px;
    background-color: #fff;
    @media (--tablet-viewport) {
      padding: 30px;
    }
    @media (--phone-viewport) {
      padding: 20px 15px;
    }
  }

  .sign__input {
    margin-bottom: 24px;
  }

  .sign__actions {
    text-align: right;
  }

  .sign__button {
    display: inline-block;
    width: 116px;
    padding: 12px 10px 11px;
    background: #277EE8;
    border-radius: 2px;
    font-size: 13px;
    font-weight: 500;
    color: #FFFFFF;
    letter-spacing: .6px;
    text-transform: uppercase;
    border: 1px solid transparent;
    box-sizing: border-box;
    transition: color .3s ease, background-color .3s ease, border-color .3s ease;
    &:hover {
      color: #277EE8;
      background-color: #fff;
      border-color: #277EE8;
    }
    &:active {
      color: #277EE8;
      background-color: #fff;
      border-color: #277EE8;
    }
  }
</style>
