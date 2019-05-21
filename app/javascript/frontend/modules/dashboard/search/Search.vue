<template>
  <div class="search-group">
    <v-layout
      row
      wrap
    >
      <v-flex
        xs12
        md3
      >
        <v-select label="Любая категория" />
      </v-flex>
      <v-flex
        xs12
        md4
      >
        <v-text-field label="Поиск по объявлениям" />
      </v-flex>
      <v-flex
        xs12
        md3
      >
        <v-select label="Москва" />
      </v-flex>
      <v-flex
        xs12
        md2
      >
        <v-btn
          block
          depressed
        >
          Найти
        </v-btn>
      </v-flex>
    </v-layout>
    <v-layout
      row
      wrap
    >
      <v-flex
        xs12
        sm4
        md3
      >
        <v-checkbox
          label="только в названиях"
          :hide-details="true"
          class="ma-0 pa-0"
        />
      </v-flex>
      <v-flex
        xs12
        sm4
        md3
      >
        <v-checkbox
          label="только с фото"
          :hide-details="true"
          class="ma-0 pa-0"
        />
      </v-flex>
    </v-layout>
  </div>
</template>
