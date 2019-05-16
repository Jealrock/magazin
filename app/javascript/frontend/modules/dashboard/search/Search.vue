<template>
  <div class="search-group">
    <v-layout row wrap>
      <v-flex lg3>
        <v-select label="Любая категория" />
      </v-flex>
      <v-flex lg4>
        <v-text-field label="Поиск по объявлениям" />
      </v-flex>
      <v-flex lg3>
        <v-select label="Москва" />
      </v-flex>
      <v-flex lg2>
        <v-btn flat>Найти</v-btn>
      </v-flex>
    </v-layout>
    <v-layout row wrap>
      <v-flex lg2>
        <v-checkbox label="только в названиях"/>
      </v-flex>
      <v-flex lg2>
        <v-checkbox label="только с фото"/>
      </v-flex>
    </v-layout>
  </div>
</template>
