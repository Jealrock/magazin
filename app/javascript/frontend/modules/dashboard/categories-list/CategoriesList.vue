<template>
  <div class="categories-list">
    <v-layout row wrap>
      <v-layout column wrap v-for="i in 3">
        <a href="#" v-for="j in 3">Foobar</a>
      </v-layout>
    </v-layout>
  </div>
</template>
