<template>
  <div class="categories-list">
    <v-layout
      row
      wrap
    >
      <v-layout
        v-for="i in 3"
        column
        wrap
      >
        <a
          v-for="j in 3"
          href="#"
        >Foobar</a>
      </v-layout>
    </v-layout>
  </div>
</template>
