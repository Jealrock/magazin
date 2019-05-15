<template>
  <header class="header">
    <v-container class="pa-0">
      <v-layout row wrap align-center>
        <v-flex lg6>
          <nav class="header__nav">
            <a href="#" class="nav__link">Объявления</a>
            <a href="#" class="nav__link">Магазины</a>
            <a href="#" class="nav__link">Бизнес</a>
            <a href="#" class="nav__link">Помощь</a>
          </nav>
        </v-flex>
        <v-flex lg6>
          <v-layout justify-end>
            <v-icon>favorite</v-icon>
            <v-btn flat small>Вход и регистрация</v-btn>
            <v-btn depressed small color="info">Подать объявление</v-btn>
          </v-layout>
        </v-flex>
      </v-layout>
    </v-container>
  </header>
</template>

<style>
.header {
  border-bottom: 1px solid #d8d8d8;
  background-color: #f7f7f7;
}
</style>
