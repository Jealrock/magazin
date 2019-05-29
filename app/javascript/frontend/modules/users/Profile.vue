<template>
  <div class="user-profile">
    <v-container pa-0 px-3>
      <v-layout row wrap
        class="mt-3">
        <v-flex xs12 sm3>
          <div class="grey lighten-3 px-3 py-2">
            <router-link to="/profile/settings"
              class="link link_green body-1 font-weight-bold">
              Настройки
            </router-link>
          </div>
        </v-flex>
        <v-flex xs12 sm9 class="pl-3">
          <p>Ваши объявления</p>
          <v-divider />
          <p>Пока у вас нет объявлений</p>
          <v-btn depressed flat
            class="button_green white--text body-1 font-weight-regular text-none px-3 ma-0"
            @click="$router.push('/offer')">
            Подать объявление
          </v-btn>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<style>
.button {
  &_green {
    background: #97cf27;
  }
}
</style>

<style scoped>
@media only screen and (min-width: 1264px) {
  .container {
      max-width: 1000px;
  }
}
</style>
