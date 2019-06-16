<template>
  <div>
    <v-container class="pa-0 px-3">
      <v-layout row wrap class="mt-3">
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  computed: {
    ...mapGetters(['currentUser', 'authData']),

		channelId() {
			return `${this.currentUser.id}_messages_channel`;
		}
	},

	channels: {
		[this.channelId]: {
			connected() {
				console.log("I am connected to a user's messages channel.");
			}
		}
	},

	mounted() {
		this.$cable.subscribe(
			{ channel: 'MessagesChannel', auth: this.authData },
			this.channelId
		);
	}
};
</script>
