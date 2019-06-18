<template>
  <div>
    <v-layout row wrap>
      <v-flex xs12>
        <v-list>
          <v-list-tile v-for="thread in threads" :key="thread.id" avatar @click="switchThread(thread.with_user.id)">
            <v-list-tile-avatar>
              <v-img v-if="thread.with_user.photo.url" :src="thread.with_user.photo.url" alt="user_photo"/>
              <v-icon v-else dark>account_circle</v-icon>
            </v-list-tile-avatar>

            <v-list-tile-content>
              <v-list-tile-title v-html="thread.with_user.name"></v-list-tile-title>
              <v-list-tile-sub-title v-html="thread.text"></v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import { messageThreadsService } from './services/messagesThreadsService';

export default {
  data: () => ({
    threads: []
  }),

  computed: {
    ...mapGetters(['currentUser'])
  },

  methods: {
    loadMessageThreads() {
      messageThreadsService.all().then(resp => {
        this.threads = resp.map(lastMessage => {
          return {
            id: lastMessage.id,
            text: this.buildThreadText(lastMessage.attributes),
            with_user: this.buildWithUserAttributes(lastMessage.attributes),
          }
        });
      });
    },
    
    switchThread(userId) {
      this.$router.push({
        path: '/profile/messages',
        query: {
          with_user_id: userId,
        },
      });
    },

    buildWithUserAttributes(message) {
      if (message.from_user.id == this.currentUser.id) {
        return {
          id: message.to_user.id,
          name: message.to_user.name,
          photo: message.to_user.photo
        }
      } else {
        return {
          id: message.from_user.id,
          name: message.from_user.name,
          photo: message.from_user.photo
        }
      }
    },

    buildThreadText(message) {
      return `<span class='text--primary'>${message.from_user.name}</span> &mdash; ${message.text}`;
    }
  },

  created() {
    this.loadMessageThreads();
  }
}
</script>
