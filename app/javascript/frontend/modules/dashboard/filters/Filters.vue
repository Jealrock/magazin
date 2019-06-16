<template>
  <div>
    <v-layout row wrap class="">
      <v-flex xs12>
        <p class="body-2 mb-0">Цена</p>
      </v-flex>
      <v-flex xs6>
        <v-text-field
          v-model="minPrice"
          placeholder="от"
          class="mt-0 pt-0"
          :hide-details="true"
          @keyup.enter="filter"
        />
      </v-flex>
      <v-flex xs6>
        <v-text-field
          v-model="maxPrice"
          placeholder="до"
          class="mt-0 pt-0"
          :hide-details="true"
          @keyup.enter="filter"
        />
      </v-flex>
      <v-flex xs12 class="mt-4">
        <p class="body-2 mb-0">Дата</p>
      </v-flex>
      <v-flex xs6>
        <v-menu
          ref="minDateMenu"
          v-model="minDateMenu"
          :close-on-content-click="false"
          lazy
          transition="scale-transition"
          offset-y
          full-width
          min-width="290px">
          <template v-slot:activator="{ on }">
            <v-text-field
              v-model="minDate"
              placeholder="от"
              class="mt-0 pt-0"
              :hide-details="true"
              v-on="on"
              @keyup.enter="filter" />
          </template>
          <v-date-picker v-model="minDate" 
            no-title
            @input="minDateMenu = false">
            <v-btn flat depressed
              color="error"
              @click="minDate = null; minDateMenu = false">
              очистить
            </v-btn>
          </v-date-picker>
        </v-menu>
      </v-flex>
      <v-flex xs6>
        <v-menu
          ref="maxDateMenu"
          v-model="maxDateMenu"
          :close-on-content-click="false"
          lazy
          transition="scale-transition"
          offset-y
          full-width
          min-width="290px">
          <template v-slot:activator="{ on }">
            <v-text-field
              v-model="maxDate"
              placeholder="до"
              class="mt-0 pt-0"
              :hide-details="true"
              v-on="on"
              @keyup.enter="filter" />
          </template>
          <v-date-picker v-model="maxDate" 
            no-title
            @input="maxDateMenu = false">
            <v-btn flat depressed
              color="error"
              @click="maxDate = null; maxDateMenu = false">
              очистить
            </v-btn>
          </v-date-picker>
        </v-menu>
      </v-flex>
      <v-flex xs12 class="mt-4">
        <v-checkbox
          v-model="onlyWithPhotos"
          label="Только с фото"
          class="mt-0"
          :hide-details="true"
        />
      </v-flex>
      <v-flex xs12>
        <v-btn block small depressed
          color="info"
          class="mt-4"
          @click="filter">
          Показать
        </v-btn>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>

export default {
  data: () => ({
    minDateMenu: false,
    maxDateMenu: false,

    minPrice: null,
    maxPrice: null,
    minDate: null,
    maxDate: null,
    only_with_photos: null,
  }),

  created: function() {
    this.fillForm();
  },

  methods: {
    fillForm() {
      this.minPrice = this.$route.query.min_price;
      this.maxPrice = this.$route.query.max_price;
      this.minDate = this.$route.query.min_date;
      this.maxDate = this.$route.query.max_date;
      this.onlyWithPhotos = this.$route.query.only_with_photos === 'true'; // Костыль, чтоб перевести строку в булеан
    },

    filter() {
      this.$router.push({
        path: '/search',
        query: {
          ...this.$route.query,
          min_price: this.minPrice,
          max_price: this.maxPrice,
          min_date: this.minDate,
          max_date: this.maxDate,
          only_with_photos: this.onlyWithPhotos,
        },
      });
    },
  },

  watch: {
    '$route': 'fillForm',
  },
};
</script>
