<template>
  <div class="subscriptions-list">
    <v-container class="pa-0 px-3 pb-5">
      <v-layout row wrap
        class="mt-3">
        <v-flex xs12 sm3>
          <ProfileNavigation :class="{
            'mr-3' : $vuetify.breakpoint.smAndUp,
          }"/>
        </v-flex>
        <v-flex xs12 sm9>
          <h1 class="font-weight-bold">Подписки</h1>
          <v-divider class="my-3" />
          <v-layout
            row wrap justify-center>
            <v-flex xs12 sm8>
              <v-card class="mb-4 px-3 py-2">
                <CategorySubscriptionsForm />
              </v-card>
              <v-card>
                <v-list>
                  <v-list-tile v-if="!subscriptions.length">
                    <v-list-tile-content>
                      <v-list-tile-title v-text="'Пока у вас нет подписок'" />
                    </v-list-tile-content>
                  </v-list-tile>
                  <v-list-tile v-else
                    v-for="(item, index) in subscriptions"
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

import ProfileNavigation from '@frontend/modules/users/profile/ProfileNavigation';
import CategorySubscriptionsForm from './form/CategorySubscriptionsForm';

import {
  categorySubscriptionsService,
} from './services/categorySubscriptionsService';

export default {
  components: {
    ProfileNavigation, CategorySubscriptionsForm,
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
