<template>
  <div>
    <v-navigation-drawer absolute app temporary
      v-model="aside">
      <v-toolbar flat
        height="100px"
        class="info"
        @click="$router.push(currentUser.uid ? '/profile' : '/sign_in')">
        <v-list class="pa-0">
          <v-list-tile v-if="!currentUser.uid" avatar>
            <v-list-tile-avatar
              :size="70"
              color="grey lighten-3">
              <v-icon>person_outline</v-icon>
            </v-list-tile-avatar>
            <v-list-tile-content class="ml-4">
              <v-list-tile-title
                class="subheading white--text font-weight-bold">
                Вход и регистрация 
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
          <v-list-tile v-else avatar>
            <v-list-tile-avatar v-if="currentUser.photo.url"
              :size="70">
              <v-img :src="currentUser.photo.url" />
            </v-list-tile-avatar>
            <v-list-tile-avatar v-else
              :size="70"
              color="grey lighten-3">
              <v-icon>person_outline</v-icon>
            </v-list-tile-avatar>
            <v-list-tile-content class="ml-4">
              <v-list-tile-title
                class="subheading white--text font-weight-bold">
                {{ currentUser.name || 'Профиль' }}
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-toolbar>
      <v-list class="pa-0">
        <v-list-tile>
          <v-list-tile-action>
            <v-icon>search</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <router-link to="/"
              class="black--text d-flex full_height full_width align-center">
              Поиск объявлений
            </router-link>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile>
          <v-list-tile-action>
            <v-icon>favorite_border</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <router-link to="/profile/favorites"
              class="black--text d-flex full_height full_width align-center">
              Избранное
            </router-link>
          </v-list-tile-content>
        </v-list-tile>
        <v-divider />
        <v-list-tile
          height="52px">
          <v-list-tile-action>
            <v-icon color="info">add_circle</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <router-link to="/offer"
              class="info--text d-flex full_height full_width align-center">
              Добавить объявление
            </router-link>
          </v-list-tile-content>
        </v-list-tile>
        <div v-if="currentUser.uid">
          <v-divider />
          <v-list-tile @click="logout">
            <v-list-tile-action>
              <v-icon color="error">exit_to_app</v-icon>
            </v-list-tile-action>
            <v-list-tile-content
              class="error--text d-flex full_height full_width">
              Выйти
            </v-list-tile-content>
          </v-list-tile>
        </div>
        <div>
          <v-divider />
          <v-list-tile v-if="currentLocale == 'en'"
            @click="switchLocale('ru')">
            <v-list-tile-action>
              <div>
                <v-img :src="ruFlag"
                  :width="'24px'" />
              </div>
            </v-list-tile-action>
            <v-list-tile-content>
              Переключиться на русский
            </v-list-tile-content>
          </v-list-tile>
          <v-list-tile v-else
            @click="switchLocale('en')">
            <v-list-tile-action>
              <div>
                <v-img :src="enFlag"
                  :width="'24px'" />
              </div>
            </v-list-tile-action>
            <v-list-tile-content>
              Switch to English
            </v-list-tile-content>
          </v-list-tile>
        </div>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

import { authService } from '@frontend/modules/auth/services/authService';

import translateService from '@frontend/core/services/translationService';

export default {
  data: () => ({
    error: null,

    ruFlag: require('@frontend/assets/ru-flag.svg'),
    enFlag: require('@frontend/assets/en-flag.svg')
  }),

  computed: {
    ...mapGetters([
      'currentUser',
      'isAsideOpen',
    ]),

    currentLocale() {
      return translateService.currentLocale();
    },

    aside: {
      get() {
        return this.isAsideOpen;
      },

      set(value) {
        this.setAside(value);
      },
    },
  },

  methods: {
    ...mapMutations([
      'clearUsersState',
      'setAside',
    ]),

    switchLocale(lang) {
      translateService.translate(lang);
    },

    logout() {
      authService.signout()
        .then((respone) => {
          this.clearUsersState();
          this.$router.push('/');
        })
        .catch((error) => this.error = error);
    }
  },
};
</script>
