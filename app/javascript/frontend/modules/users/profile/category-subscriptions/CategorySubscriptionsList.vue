<template>
  <div class="subscriptions-list">
    <v-container class="pa-0 px-3 pb-5">
      <v-layout row wrap
        class="mt-3">
        <CategoriesDialog ref="categoriesDialog" />
        <v-flex xs12 sm3>
          <ProfileNavigation :class="{
            'mr-3' : $vuetify.breakpoint.smAndUp,
          }"/>
        </v-flex>
        <v-flex xs12 sm9>
          <h1 class="font-weight-bold">Подписки</h1>
          <v-btn depressed flat
            class="button_green white--text body-1 font-weight-regular text-none px-3 ma-0 mt-2"
            @click="showCategorySeletionDialog">
            Добавить подписку
          </v-btn>
          <v-divider class="my-3" />
          <p v-if="!subscriptions.length">Пока у вас нет подписок</p>
          <v-layout v-else
            row wrap justify-center>
            <v-flex xs12 sm8>
              <v-card>
                <v-list>
                  <v-list-tile v-for="(item, index) in subscriptions"
                    :key="index">
                    <v-list-tile-content>
                      <v-list-tile-title v-text="item.title" />
                    </v-list-tile-content>
                    <v-list-tile-action>
                      <v-btn icon
                        @click="deleteSubscription(item.id)">
                        <v-icon color="grey lighten-1">
                          cancel
                        </v-icon>
                      </v-btn>
                    </v-list-tile-action>
                  </v-list-tile>
                </v-list>
              </v-card>
            </v-flex>
          </v-layout>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';

import {
  categorySubscriptionsService,
} from './services/categorySubscriptionsService';

import ProfileNavigation from '@frontend/modules/users/profile/ProfileNavigation';
import CategoriesDialog from './dialog/CategoriesDialog';

export default {
  components: {
    ProfileNavigation, CategoriesDialog,
  },

  computed: {
    ...mapGetters({
      subscriptions: 'getAllCategoriesSubscriptions',
    }),
  },

  methods: {
    ...mapMutations([
      'removeCategorySubscription',
    ]),

    showCategorySeletionDialog() {
      this.$refs.categoriesDialog.showDialog();
    },

    deleteSubscription(categoryId) {
      categorySubscriptionsService.destroy(categoryId)
        .then((response) => {
          this.removeCategorySubscription(response.data.data.attributes.id);
        })
        .catch((error) => {
          throw new Error(error);
        });
    },
  },
};
</script>
