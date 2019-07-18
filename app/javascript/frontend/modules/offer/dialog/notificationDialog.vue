<template>
  <div>
    <v-dialog
      v-model="mainDialog"
      width="600">
      <v-card>
        <v-card-title primary-title>
          <h4 class="mb-0 mx-auto font-weight-bold text-uppercase">Отправить уведомление</h4>
          <v-container class="pa-0">
            <v-layout row wrap justify-center class="mt-4">
              <v-flex xs12 sm6
                :class="{ 'pr-2' : $vuetify.breakpoint.smAndUp }">
                <MegakassaForm 
                  v-if="allPayment"
                  :shopId="allPayment.shop_id"
                  :price="allPayment.price"
                  :description="allPayment.description"
                  :orderId="allPayment.order_id"
                  :signature="allPayment.signature"
                >
                  <template v-slot:submitBtn>
                    <v-btn type="submit" block depressed color="info">Всем пользователям</v-btn>
                  </template>
                </MegakassaForm>
              </v-flex>
              <v-flex xs12 sm6 
                :class="{ 
                  'pl-2' : $vuetify.breakpoint.smAndUp,
                  'mt-2' : $vuetify.breakpoint.xsOnly,
                }">
                <v-btn
                  block
                  depressed
                  color="success"
                  @click="showSettingDialog">
                  Конкретным пользователям
                </v-btn>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-title>
      </v-card>
    </v-dialog>
    <v-dialog v-model="settingsDialog"
      :width="600">
      <v-card>
        <v-card-title primary-title>
          <h4 class="mb-0 mx-auto font-weight-bold text-uppercase">Отправить уведомление пользователям</h4>
          <v-container class="pa-0">
            <v-layout row wrap justify-center class="mt-4">
              <v-flex xs12 sm6>
                <v-checkbox
                  v-model="notifyByCategories"
                  label="По категориям" />
              </v-flex>
              <v-flex xs12 sm6>
                <v-autocomplete
                  v-model="selectedCategories"
                  :disabled="!notifyByCategories"
                  multiple chips
                  :items="categories"
                  item-value="id"
                  item-text="title"
                  label="Укажите категории">
                  <template v-slot:item="data">
                    <v-list-tile-content>
                      <v-list-tile-title
                        :class="{
                          'body-1' : data.item.parent_id,
                          'subheading font-weight-bold' : !data.item.parent_id,
                        }">
                        {{ data.item.title }}
                      </v-list-tile-title>
                    </v-list-tile-content>
                  </template>
                </v-autocomplete>
              </v-flex>
              <v-flex xs12 sm6>
                <v-checkbox
                  v-model="notifyByGeo"
                  label="По геолокации" />
              </v-flex>
              <v-flex xs12 sm6>
                <AutocompleteInput 
                  :disabled="!notifyByGeo"
                  :items="suggestedCities"
                  :placeholder="'Москва'"
                  :multiple="true"
                  :chips="true"
                  :value="selectedCities"
                  :loaded="suggestedCitiesLoaded"
                  class="white mt-0 pt-0"
                  :hideDetails="true"
                  @update="onCityUpdate"
                  @change="onCitiesChange"
                />
              </v-flex>
              <v-flex xs12 sm6 :class="{ 'pr-2' : $vuetify.breakpoint.smAndUp }">
                <MegakassaForm 
                  v-if="targetPayment"
                  :shopId="targetPayment.shop_id"
                  :price="targetPayment.price"
                  :description="targetPayment.description"
                  :orderId="targetPayment.order_id"
                  :signature="targetPayment.signature"
                  :categories="selectedCategories"
                  :cities="selectedCities"
                >
                  <template v-slot:submitBtn>
                    <v-btn type="submit" block depressed color="success">Отправить</v-btn>
                  </template>
                </MegakassaForm>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-title>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import AutocompleteInput from '@frontend/core/components/form/AutocompleteInput';
import MegakassaForm from '@frontend/modules/payments/MegakassaForm';
import geolocationsService from '@frontend/core/services/geolocationsService';

import { mapGetters, mapMutations, mapActions } from 'vuex';
import { offersService } from '@frontend/modules/offer/services/offersService';

export default {
  components: {
    AutocompleteInput,
    MegakassaForm
  },

  props: {
    offerId: {
      type: Number,
      required: true,
    },
  },

  data: () => ({
    mainDialog: false,
    settingsDialog: false,

    notifyByCategories: true,
    notifyByGeo: false,

    suggestedCities: [], 
    suggestedCitiesLoaded: true, 
    selectedCities: [],

    selectedCategories: [],

    allPayment: null,
    targetPayment: null
  }),

  computed: {
    ...mapGetters([
      'mainCategories',
      'childCategories',
    ]),

    categories() {
      return this.mainCategories.reduce((acc, cur) => {
        if (acc.length !== 0) acc.push({ divider: true });
        acc.push(cur);
        return acc.concat(this.childCategories(cur.id).map(category => category));
      }, []);
    },
  },

  methods: {
    ...mapMutations([
      'setOffer',
    ]),

    onCitiesChange(cities) {
      this.selectedCities = cities;
    },

    async onCityUpdate(inputCity) {
      this.suggestedCitiesLoaded = false;

      geolocationsService.search(inputCity)
        .then(locations => {
          // to correctly connect Geocoder ruby gem
          this.suggestedLocations = locations;
          this.suggestedCities = this._.uniq(
            this.selectedCities.concat(
              locations.filter(location => location.city).map(location => location.city)
            )
          );
        })
        .catch(error => this.error = error)
        .finally(() => this.suggestedCitiesLoaded = true)
    },

    showMainDialog(allPayment, targetPayment) {
      this.allPayment = allPayment;
      this.targetPayment = targetPayment;
      this.mainDialog = true;
      this.settingsDialog = false;
    },

    showSettingDialog() {
      this.mainDialog = false;
      this.settingsDialog = true;
    },

    notify() {
      this.mainDialog = false;
      this.settingsDialog = false;
      this.selectedCategories = [];
    },
  },
};
</script>
