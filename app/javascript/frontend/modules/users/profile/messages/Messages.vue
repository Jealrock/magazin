<template>
  <v-container class="pa-0 px-3" fluid fill-height>
    <v-layout row wrap justify-top align-center class="mt-3">
      <v-flex xs12 sm3 fill-height>
        <ProfileNavigation :class="{
          'mr-3' : $vuetify.breakpoint.smAndUp,
        }"/>
        <MessageThreads 
          :class="{
            'mr-3' : $vuetify.breakpoint.smAndUp,
          }"
        />
      </v-flex>
      <v-flex xs12 sm9 fill-height>
        <h1 class="font-weight-bold">Сообщения</h1>
        <template v-if="withUser">
          <v-list class="thread-messages" style="overflow-y: auto; max-height: 80%;">
            <v-list-tile v-for="message in currentThreadMessages" :key="message.id" avatar>
              <template v-if="message.from_user_id == currentUser.id">
                <v-list-tile-avatar>
                  <v-img v-if="currentUser.photo" :src="currentUser.photo.url" alt="user_photo"/>
                  <v-icon v-else>account_circle</v-icon>
                </v-list-tile-avatar>

                <v-list-tile-content>
                  <v-list-tile-title v-text="currentUser.name"></v-list-tile-title>
                  <v-list-tile-sub-title v-text="message.text"></v-list-tile-sub-title>
                </v-list-tile-content>

                <v-list-tile-action>
                  <v-list-tile-action-text>{{ message.created_at | moment('calendar').toLowerCase() }}</v-list-tile-action-text>
                </v-list-tile-action>
              </template>

              <template v-else>
                <v-list-tile-avatar>
                  <v-img v-if="withUser.photo.url" :src="withUser.photo.url" alt="user_photo"/>
                  <v-icon v-else>account_circle</v-icon>
                </v-list-tile-avatar>

                <v-list-tile-content>
                  <v-list-tile-title v-text="withUser.name"></v-list-tile-title>
                  <v-list-tile-sub-title v-text="message.text"></v-list-tile-sub-title>
                </v-list-tile-content>

                <v-list-tile-action>
                  <v-list-tile-action-text>{{ message.created_at | moment('calendar').toLowerCase() }}</v-list-tile-action-text>
                </v-list-tile-action>
              </template>
            </v-list-tile>
          </v-list>
          <v-divider class="mt-3 mb-4" />
          <v-text-field
            v-model="newMessageText"
            :append-outer-icon="'send'"
            box
            placeholder="Введите сообщениe"
            type="text"
            @click:append-outer="sendMessage"
          ></v-text-field>
        </template>
        <v-subheader v-else class="font-weight-bold">Выберите чат слева</v-subheader>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';

import ProfileNavigation from '@frontend/modules/users/profile/ProfileNavigation';

import { messagesService } from './services/messagesService';
import { usersService } from '@frontend/modules/users/services/usersService';
import MessageThreads from './MessageThreads';

export default {
  components: {
    ProfileNavigation, MessageThreads
  },

  data: () => ({
    withUser: null,
    currentThreadMessages: [],
    newMessageText: '' 
  }),

  computed: {
    ...mapGetters(['currentUser', 'authData']),

		channelId() {
			return `${this.currentUser.id}_messages_channel`;
		}
	},

	channels: {
		MessagesChannel: {
      received(data) {
        this.currentThreadMessages.push(JSON.parse(data).data.attributes)
      },
		}
	},

  methods: {
    loadMessages() {
      if (!this.$route.query.with_user_id) {
        this.currentThreadMessages = [];
        return;
      };

      messagesService
        .all(this.$route.query.with_user_id)
        .then(resp => this.currentThreadMessages = resp.map(message => message.attributes));
    },

    loadWithUser() {
      if (!this.$route.query.with_user_id) {
        this.withUser = null;
        return;
      };

      usersService
        .find(this.$route.query.with_user_id)
        .then(resp => this.withUser = resp.attributes);
    },

    sendMessage() {
      if (!this.$route.query.with_user_id) return;

      messagesService
        .create({ text: this.newMessageText, to_user_id: this.$route.query.with_user_id })
        .then(resp => {
          this.currentThreadMessages.push(resp.attributes)
          this.newMessageText = '';
        });
    }
  },

  created() {
    this.loadMessages();
    this.loadWithUser();
  },

	mounted() {
		this.$cable.subscribe(
      { 
        channel: 'MessagesChannel', 
        room: this.currentUser.id,
        auth: { ...this.authData, 'access-token': this.authData.accessToken } 
      }
		);
	},

  watch: {
    '$route' () {
      this.loadMessages();
      this.loadWithUser();
    }
  }
};
</script>
