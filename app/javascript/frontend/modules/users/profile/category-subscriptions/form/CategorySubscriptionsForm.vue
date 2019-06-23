<template>
  <div>
    <v-layout row wrap>
      <v-flex xs12>
        <v-form
          ref="form"
          v-model="valid">
          <v-layout row wrap>
            <v-flex xs12 sm6
              :class="{
                'pr-2' : $vuetify.breakpoint.smAndUp,
              }">
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
            </v-flex>
            <v-flex xs12 sm6
              class="align-self-center"
              :class="{
               'pl-2' : $vuetify.breakpoint.smAndUp,
              }">
              <v-btn
                block
                depressed
                color="success"
                class="ma-0"
                @click="addSubscription">
                Добавить подписку
              </v-btn>
            </v-flex>
          </v-layout>
        </v-form>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapMutations, mapGetters, mapActions } from 'vuex';

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
      isSubscribed: 'isSubscribed',
    }),

    availableCategories() {
      return this.mainCategories.reduce((acc, cur) => {
        if (acc.length !== 0) acc.push({ divider: true });
        acc.push(cur);
        return acc.concat(this.childCategories(cur.id).filter((category) => {
          if (!this.isSubscribed(category.id)) return category;
        }));
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

    async addSubscription() {
      await this.$validator.validateAll();
      if (!this.valid) return;

      categorySubscriptionsService.create({
        category_id: this.selectedCategoryId,
      })
        .then((response) => {
          this.addCategorySubscription(response.data.data.attributes);
          this.selectedCategoryId = null;
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
