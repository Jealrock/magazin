<template>
  <header class="header">
    <v-container class="pa-0 px-3">
      <v-layout row wrap align-center>
        <v-flex xs6 hidden-sm-and-down>
          <nav class="nav">
            <a href="#" class="header__link pl-0">Объявления</a>
            <a href="#" class="header__link">Магазины</a>
            <a href="#" class="header__link">Бизнес</a>
            <a href="#" class="header__link">Помощь</a>
          </nav>
        </v-flex>
        <v-flex xs6 hidden-sm-and-down>
          <v-layout justify-end>
            <v-icon class="grey--text text--lighten-1">favorite</v-icon>
            <v-btn flat small class="ma-0">Вход и регистрация</v-btn>
            <v-btn depressed small color="info" class="ma-0">Подать объявление</v-btn>
          </v-layout>
        </v-flex>
        <v-flex xs12 hidden-md-and-up>
          <v-toolbar-side-icon></v-toolbar-side-icon>
        </v-flex>
      </v-layout>
    </v-container>
  </header>
</template>

<style>
.header {
  border-bottom: 1px solid #d8d8d8;
  background-color: #f7f7f7;
  padding-top: 5px;
  padding-bottom: 5px;
}

.nav {
  display: flex;
  flex-wrap: wrap;
}

.header__link {
  font-size: 1rem;
  font-weight: 400;
  padding: .5rem 1rem;
}

.header .header__link {
  color: #a1a1a1;
}

.header__link:hover {
  color: #ff6163;
}
</style>

<style scoped>
@media only screen and (min-width: 1264px) {
  .container {
      max-width: 1000px;
  }
}
</style>
