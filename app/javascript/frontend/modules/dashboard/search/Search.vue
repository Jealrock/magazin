<template>
  <div class="search-group">
    <v-layout row wrap class="grey pa-1 round">
      <v-flex xs12 md3>
        <v-select
          v-model="category_id"
          placeholder="Любая категория"
          class="search__select-input white mt-0 pt-0 px-2"
          item-value="id"
          :items="categories"
          :hide-details="true"
        >
          <template slot="item" slot-scope="data">
            <div class="v-list__tile__content">
              <div class="v-list__tile__title"
                :class="{
                  'body-1' : data.item.parent_id,
                  'subheading font-weight-bold' : !data.item.parent_id,
                }">
                {{ data.item.title }}
              </div>
            </div>
          </template>
          <template slot="selection" slot-scope="data">
            <div class="v-select__selection v-select__selection--comma">
              {{ data.item.title }}
            </div>
          </template>
        </v-select>
      </v-flex>
      <v-flex xs12 md2>
        <v-select
          v-model="type"
          placeholder="Тип обьявления"
          class="search__select-input white mt-0 pt-0 px-2"
          :items="types"
          :hide-details="true"
        ></v-select>
      </v-flex>
      <v-flex xs12 md3>
        <v-text-field
          v-model="title"
          placeholder="Поиск по объявлениям"
          class="white mt-0 pt-0 px-2"
          :hide-details="true"
          @keyup.enter="find"
        />
      </v-flex>
      <v-flex xs12 md2>
        <AutocompleteInput 
          :items="suggestedCities"
          :placeholder="'Москва'"
          :value="city"
          :loaded="suggestedCitiesLoaded"
          class="white mt-0 pt-0 px-2"
          :hideDetails="true"
          @update="onCityUpdate"
          @change="onCityChange"
        />
      </v-flex>
      <v-flex xs12 md2>
        <v-btn block small flat depressed class="ma-0 white search__find-button" @click="find">
          Найти
        </v-btn>
      </v-flex>
    </v-layout>
    <v-layout row wrap>
      <!-- <v-flex xs12 sm4 md3> -->
      <!--   <v-checkbox -->
      <!--     label="только в названиях" -->
      <!--     :hide-details="true" -->
      <!--     class="ma-0 pa-0" -->
      <!--   /> -->
      <!-- </v-flex> -->
      <!-- <v-flex xs12 sm4 md3> -->
      <!--   <v-checkbox -->
      <!--     label="только с фото" -->
      <!--     :hide-details="true" -->
      <!--     class="ma-0 pa-0" -->
      <!--   /> -->
      <!-- </v-flex> -->
    </v-layout>
  </div>
</template>

<script>
import AutocompleteInput from '@frontend/core/components/form/AutocompleteInput';
import geolocationsService from '@frontend/core/services/geolocationsService';
import { mapGetters } from 'vuex';

export default {
  components: {
    AutocompleteInput
  },

  data: () => ({
    suggestedCities: [], 
    suggestedCitiesLoaded: true, 
    types: [{
      text: 'Все',
      value: null,
    }, {
      text: 'Обменяю',
      value: 'ExchangeOffer',
    }, {
      text: 'Продам',
      value: 'CashOffer',
    }, {
      text: 'Услуги',
      value: 'ServiceOffer',
    }, {
      text: 'Отдам БисмилЛах1',
      value: 'FreeOffer',
    }],
    type: '',
    title: '',
    category_id: null,
    city: ''
  }),

  computed: {
    ...mapGetters(['mainCategories', 'childCategories']),

    categories() {
      return [{id: null, parent_id: null, title: 'Все категории',}].concat(
        this.mainCategories.reduce((acc, cur) => {
          if (acc.length != 0) acc.push({ divider: true });
          acc.push(cur);
          return acc.concat(this.childCategories(cur.id).map(category => category));
        }, [])
      );
    }
  },

  created: function () {
    this.fillForm();
  },

  methods: {
    onCityChange(city) {
      this.city = city;
    },

    async onCityUpdate(inputCity) {
      this.suggestedCitiesLoaded = false;

      geolocationsService.search(inputCity)
        .then(locations => {
          // to correctly connect Geocoder ruby gem
          this.suggestedLocations = locations;
          this.suggestedCities = this._.uniq(
            locations.filter(location => location.city).map(location => location.city)
          );
        })
        .catch(error => this.error = error)
        .finally(() => this.suggestedCitiesLoaded = true)
    },

    fillForm() {
      this.title = this.$route.query.by_title;
      this.category_id = this.$route.query.by_category_id && parseInt(this.$route.query.by_category_id);
      this.city = this.$route.query.by_city;
      this.type = this.$route.query.by_type;

      if (this.city && this.city.length != 0) this.suggestedCities = [this.city];
    },

    find() {
      this.$router.push({ 
        path: '/',
        query: {
          ...this.$route.query,
          by_title: this.title,
          by_category_id: this.category_id,
          by_city: this.city,
          by_type: this.type
        }
      });
    }
  },

  watch: {
    '$route': 'fillForm'
  }
}
</script>

<style>
.v-btn.search__find-button {
  height: 100%;
  border-radius: 0;
}

.search__select-input .v-select__selection {
  white-space: nowrap;
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 90%
}
</style>
