<template>
  <div class="search-group">
    <v-layout
      row
      wrap
      class="grey pa-1 round"
    >
      <v-flex
        xs12
        md3
      >
        <v-select
          placeholder="Любая категория"
          class="white mt-0 pt-0 px-2"
          :hide-details="true"
        />
      </v-flex>
      <v-flex
        xs12
        md4
      >
        <v-text-field
          placeholder="Поиск по объявлениям"
          class="white mt-0 pt-0 px-2"
          :hide-details="true"
        />
      </v-flex>
      <v-flex
        xs12
        md3
      >
        <v-select
          placeholder="Москва"
          class="white mt-0 pt-0 px-2"
          :hide-details="true"
        />
      </v-flex>
      <v-flex
        xs12
        md2
      >
        <v-btn
          block
          small
          flat
          depressed
          class="ma-0 white search__find-button"
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

<style scoped>
.search__find-button {
  height: 100%;
  border-radius: 0;
}
</style>
