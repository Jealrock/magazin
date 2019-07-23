<template>
  <div class="notification">
    <v-slide-x-reverse-transition>
      <v-card v-show="visible"
        class="mt-4 blue lighten-1 cursor_pointer elevation-15"
        @click="openOfferPage">
        <v-btn icon
          absolute
          class="ma-0 notification__close-button"
          @click="closeNotification(notificationIndex, $event)">
          <v-icon>
            cancel
          </v-icon>
        </v-btn>
        <v-layout row>
          <v-img :src="notificationItem.icon"
            class="blue"
            :aspect-ration="1"
            :min-width="'80px'" 
            :max-width="'110px'" />
          <v-card-title primary-title>
            <div>
              <p class="ma-0 mb-3 title font-weight-bold">
                {{ notificationItem.title }}
              </p>
              <p class="ma-0 subheading">
                {{ notificationItem.body }}
              </p>
            </div>
          </v-card-title>
        </v-layout>
      </v-card>
    </v-slide-x-reverse-transition>
  </div>
</template>

<script>
import { mapMutations } from 'vuex';

export default {
  props: {
    notificationItem: {
      type: Object,
      default: () => {},
    },
    notificationIndex: {
      type: Number,
      required: true,
    },
  },

  data: () => ({
    visible: false,
  }),

  mounted() {
    // This needs to toggle slide animation after creating element
    this.visible = true;
  },

  methods: {
    ...mapMutations([
      'deleteNotification',
    ]),

    closeNotification(index, event) {
      event.stopPropagation();
      this.visible = false;
    },

    openOfferPage(event) {
      event.stopPropagation();

      const offerId = this.notificationItem.offer_id;
      window.location = `/offer/${offerId}`;
    },
  },
};
</script>

<style>
.notification__close-button {
  top: 5px;
  right: 5px;
}
</style>
