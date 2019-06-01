<template>
  <header class="header">
    <v-container class="pa-0 px-3">
      <v-layout row wrap align-center>
        <v-flex xs6 hidden-sm-and-down>
          <nav class="nav">
            <router-link
              to="/"
              class="link link_grey body-1 py-2 pr-3"
            >
              Объявления
            </router-link>
          </nav>
        </v-flex>
        <v-flex xs6 hidden-sm-and-down>
          <v-layout justify-end align-center>
            <v-icon class="grey--text text--lighten-1">favorite</v-icon>

            <router-link v-if="!currentUser.uid"
              to="/sign_in"
              class="link link_blue body-1 px-4">
              Вход и регистрация
            </router-link>
            
            <div v-else>
              <a class="link link_grey body-1 pl-4 pr-3"
                @click="logout">Выйти</a>
              <router-link
                to="/profile"
                class="link link_grey body-1 pr-4 pl-3">
                Профиль
              </router-link>
            </div>

            <v-btn depressed small flat
              class="button_blue white--text body-1 font-weight-regular text-none px-3 ma-0"
              @click="$router.push('/offer')">
              Подать объявление
            </v-btn>
          </v-layout>
        </v-flex>
        <v-flex xs12 hidden-md-and-up>
          <v-toolbar-side-icon @click="setAside(true)" />
        </v-flex>
      </v-layout>
    </v-container>
  </header>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';
import { authService } from '@frontend/modules/auth/services/authService';

export default {
  data: () => ({
    error: null,
    hover: false,
  }),

  computed: {
    ...mapGetters(['currentUser']),
  },

  methods: {
    ...mapMutations([
      'clearUsersState',
      'setAside',
    ]),

    logout() {
      authService.signout()
        .then((response) => {
          this.clearUsersState();
          this.$router.push('/');
        })
        .catch((error) => this.error = error);
    },
  },
};
</script>

<style>
.nav {
  display: flex;
  flex-wrap: wrap;
}

.link {
  &_blue {
    color: #0091d9;
  }

  &_grey {
    color: #a1a1a1;
  }
}

.button {
  &_blue {
    background: #01aaff;
  }
}

.link:hover {
  color: #ff6163;
}
</style>

<style scoped>
.header {
  border-bottom: 1px solid #d8d8d8;
  background-color: #f7f7f7;
  padding: 3px 0px 4px;
}
</style>
