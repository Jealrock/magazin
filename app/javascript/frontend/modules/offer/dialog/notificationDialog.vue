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
                <v-btn
                  block
                  depressed
                  color="info"
                  @click="notify">
                  Всем пользователям
                </v-btn>
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
                <v-autocomplete
                  :disabled="!notifyByGeo"
                  multiple chips
                  :items="geos"
                  label="Выберите" />
              </v-flex>
              <v-flex xs12 sm6
                :class="{ 'pr-2' : $vuetify.breakpoint.smAndUp }">
                <v-btn
                  block
                  depressed
                  color="success"
                  @click="notify">
                  Отправить
                </v-btn>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-title>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex';

import { offersService } from '@frontend/modules/offer/services/offersService';

export default {
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

    geos: [],

    selectedCategories: [],
    selectedGeos: [],
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

    ...mapActions([
      'showAlert',
    ]),

    showMainDialog() {
      this.mainDialog = true;
      this.settingsDialog = false;
    },

    showSettingDialog() {
      this.mainDialog = false;
      this.settingsDialog = true;
    },

    notify() {
      offersService.notify(this.offerId, {
          categories: this.selectedCategories,
        })
        .then(resp => {
          this.setOffer(resp);
          this.mainDialog = false;
          this.settingsDialog = false;
          this.selectedCategories = [];
          this.showAlert({
            type: 'success',
            text: 'Успешно отправлено',
          });
        });
    },
  },
};
</script>
