<template>
  <v-container class="px-3 pt-3 pb-0" fill-height>
    <v-layout row wrap justify-start align-start>
      <v-flex xs12 sm3 align-start>
        <ProfileNavigation :class="{
          'mr-3' : $vuetify.breakpoint.smAndUp,
        }"/>
        <MessageThreads 
           style="overflow-y: auto; height: 74vh;"
          :class="{
            'mr-3' : $vuetify.breakpoint.smAndUp,
          }"
          ref="messageThreads"
        />
      </v-flex>
      <v-flex xs12 sm9 aling-start>
        <h1 v-if="withUser" class="font-weight-bold">{{ 'Сообщения с ' + withUser.name }}</h1>
        <h1 v-else class="font-weight-bold">Сообщения</h1>
        <v-divider class="mt-2 mb-2" />
        <template v-if="withUser">
          <v-list class="messages-list" style="overflow-y: auto; height: 75vh;">
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
          <v-divider class="mt-2 mb-2" />
          <v-text-field
            v-model="newMessageText"
            :append-outer-icon="'send'"
            box
            label="Введите сообщениe"
            solo
            type="text"
            @keyup.enter="sendMessage"
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
        const message = JSON.parse(data).data.attributes;
        if (this.withUser && message.from_user.id == this.withUser.id) {
          this.currentThreadMessages.push(message);
          this.scrollMessageBox();
        }
        this.$refs.messageThreads.updateLastMessage(message.from_user.id, message);
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
        .then(resp => {
          this.currentThreadMessages = resp.map(message => message.attributes);
          this.scrollMessageBox();
        });
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
          this.currentThreadMessages.push(resp.attributes);
          this.$refs.messageThreads.updateLastMessage(this.withUser.id, resp.attributes);
          this.scrollMessageBox();
          this.newMessageText = '';
        });
    },

    scrollMessageBox() {
      this.$nextTick(() => {
        var container = this.$el.querySelector(".messages-list");
        container.scrollTop = container.scrollHeight;
      });
    }
  },

	mounted() {
    this.loadMessages();
    this.loadWithUser();
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
