<template>
  <div>
    <v-dialog
      v-model="categorySelectionDialog"
      width="400">
      <v-card>
        <v-card-title primary-title>
          <h4 class="mb-0 mx-auto font-weight-bold text-uppercase">Подписка на категорию</h4>
          <v-container class="pa-0">
            <v-layout row wrap justify-center class="mt-4">
              <v-flex xs12>
                <v-form
                  ref="form"
                  v-model="valid">
                  <v-select
                    v-model="selectedCategoryId"
                    v-validate="'required'"
                    label="Категория"
                    data-vv-name="category"
                    :error-messages="errors.collect('category')"
                    :items="availableCategories"
                    item-text="title"
                    item-value="id"
                    required>
                    <template slot="item" slot-scope="data">
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
                  </v-select>

                  <v-btn
                    block
                    depressed
                    color="success"
                    class="mt-4"
                    @click="addSubscription">
                    Добавить
                  </v-btn>
                </v-form>
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

import {
  categorySubscriptionsService,
} from '@frontend/modules/users/profile/category-subscriptions/services/categorySubscriptionsService';

export default {
  $_veeValidate: {
    validator: 'new',
  },

  computed: {
    ...mapGetters({
      mainCategories: 'mainCategories',
      childCategories: 'childCategories',
    }),

    availableCategories() {
      return this.mainCategories.reduce((acc, cur) => {
        if (acc.length !== 0) acc.push({ divider: true });
        acc.push(cur);
        return acc.concat(this.childCategories(cur.id).map(category => category));
      }, []);
    },
  },

  data: () => ({
    valid: true,
    selectedCategoryId: null,
    categorySelectionDialog: false,
  }),

  methods: {
    ...mapMutations([
      'addCategorySubscription',
    ]),

    ...mapActions([
      'showAlert',
    ]),

    showDialog() {
      this.categorySelectionDialog = true;
    },

    async addSubscription() {
      await this.$validator.validateAll();
      if (!this.valid) return;

      categorySubscriptionsService.create({
        category_id: this.selectedCategoryId,
      })
        .then((response) => {
          this.addCategorySubscription(response.data.data.attributes);
          this.showAlert({
            type: 'success',
            text: 'Подписка добавлена',
          });
        })
        .catch((error) => {
          throw new Error(error);
        });
    },
  },
};
</script>
