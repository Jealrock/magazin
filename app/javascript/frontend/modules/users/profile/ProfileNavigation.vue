<template>
  <div>
    <v-layout row wrap>
      <v-flex xs12>
        <div class="grey lighten-3 py-3">
          <router-link to="/profile"
            class="py-1 px-3 link link_green body-1 font-weight-bold d-block"
            :active-class="'link_active'"
            exact>
            Мои объявления
          </router-link>
          <router-link to="/profile/subscriptions"
            class="py-1 px-3 link link_green body-1 font-weight-bold d-block"
            :active-class="'link_active'"
            exact>
            Мои подписки
          </router-link>
          <router-link to="/profile/favorites"
            class="py-1 px-3 link link_green body-1 font-weight-bold d-block"
            :active-class="'link_active'"
            exact>
            Избранное
          </router-link>
          <router-link to="/profile/messages"
            class="py-1 px-3 link link_green body-1 font-weight-bold d-block"
            :active-class="'link_active'"
            exact>
            Сообщения
          </router-link>
          <router-link to="/profile/settings"
            class="py-1 px-3 link link_green body-1 font-weight-bold d-block"
            :active-class="'link_active'"
            exact>
            Настройки
          </router-link>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>
