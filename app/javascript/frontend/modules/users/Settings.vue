<template>
  <v-container>
    <v-layout row wrap justify-center>
      <v-flex xs12 sm8 md6 lg5
        :class="{ 'elevation-2' : $vuetify.breakpoint.smAndUp }">
        <h1 class="text-xs-center mt-3">
          Настройки
        </h1>
        <v-card class="elevation-0">
          <v-card-text>
            <v-alert :value="error" type="error" class="mx-0 mb-3" outline>
              <div v-html="error"/>
            </v-alert>

            <v-alert :value="success" type="success" class="mx-0 mb-3" outline>
              <div v-html="success" />
            </v-alert>

            <div>
              <v-layout row wrap justify-center
                class="pt-3 pb-4">
                <input type="file" id="photo" ref="photo" v-on:change="handlePhotoUpload()"/>
                <v-hover>
                  <v-avatar
                    slot-scope="{ hover }"
                    :size="100"
                    :class="photoUrl ? 'white' : 'info'">
                    <v-img v-if="photoUrl" :src="photoUrl" alt="photo"/>
                    <v-icon v-else dark>account_circle</v-icon>
                    <v-fade-transition>
                      <v-avatar
                        v-if="hover"
                        id="photo-hover"
                        :size="100"
                        @click="uploadPhoto()">
                        <div>
                          <v-icon class="mt-2" dark>photo_camera</v-icon><br>
                          <span class="white--text">Edit</span>
                        </div>
                      </v-avatar>
                    </v-fade-transition>
                  </v-avatar>
                </v-hover>
              </v-layout>
              <v-form ref="form" v-model="valid">
                <v-text-field
                  v-model="email"
                  v-validate="'required|email'"
                  label="e-mail"
                  type="email"
                  data-vv-name="email"
                  :error-messages="errors.collect('email')"
                  required
                  @keyup.enter="submit"
                />
                <v-text-field v-model="name" label="Имя" type="text" @keyup.enter="submit"/>
                <AutocompleteInput 
                  :items="suggestedCities"
                  :value="city"
                  :label="'Город'"
                  :loaded="suggestedCitiesLoaded"
                  @update="onCityUpdate"
                  @change="onCityChange"
                />

                <v-text-field v-model="phoneNumber" label="Номер телефона" type="text" @keyup.enter="submit"/>
                <v-layout row wrap
                  class="mt-5">
                  <v-flex
                    :class=" {
                      'xs6 offset-xs3' : $vuetify.breakpoint.smAndUp,
                      'xs12' : $vuetify.breakpoint.xsOnly
                    } ">
                    <v-btn class="ma-0" :class=" { 'info' : valid, disabled: !valid }" depressed block large @click="submit">
                      Сохранить
                    </v-btn>
                  </v-flex>
                  <v-flex xs12
                    class="mt-4">
                    <router-link
                      to="/profile"
                      class="custom-black--text d-block text-xs-center"
                    >
                      Назад
                    </router-link>
                  </v-flex>
                </v-layout>
              </v-form>
            </div>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>


<script>
import AutocompleteInput from '@frontend/core/components/form/AutocompleteInput';
import { mapGetters, mapMutations } from 'vuex'
import { usersService } from './services/usersService';
import geolocationsService from '@frontend/core/services/geolocationsService';

export default {
  $_veeValidate: {
    validator: 'new',
  },

  components: {
    AutocompleteInput
  },

  data: () => ({
    suggestedCities: [], 
    suggestedLocations: [],
    suggestedCitiesLoaded: true, 
    valid: true,
    error: null,
    success: null,
    email: null,
    name: null,
    city: '',
    phoneNumber: null,
    photo: null,
    photoUrl: null,
  }),

  computed: {
    ...mapGetters(['currentUser']),
    
    address() {
      const location = this.suggestedLocations.find(location => location.city == this.city);
      return location ? location.address : this.currentUser.address;
    }
  },

  created() {
    this.email = this.currentUser.email;
    this.name = this.currentUser.name;
    this.city = this.currentUser.city;
    this.photoUrl = this.currentUser.photo.url;
    this.phoneNumber = this.currentUser.phone_number;

    if (this.city && this.city.length != 0) this.suggestedCities = [this.currentUser.city];
  },

  methods: {
    ...mapMutations(['setCurrentUser']),

    uploadPhoto() {
      this.$refs.photo.click();
    },

    handlePhotoUpload() {
      this.photoUrl = URL.createObjectURL(this.$refs.photo.files[0]);
    },

    onCityChange(city) {
      this.city = city;
    },

    async onCityUpdate(inputCity) {
      this.suggestedCitiesLoaded = false;

      geolocationsService.search(inputCity)
        .then(locations => {
          // to correctly connect Geocoder ruby gem
          this.suggestedLocations = locations;
          this.suggestedCities = this._.uniq(
            locations.filter(location => location.city).map(location => location.city)
          );
        })
        .catch(error => this.error = error)
        .finally(() => this.suggestedCitiesLoaded = true)
    },

    async submit() {
      await this.$validator.validateAll();
      if (!this.valid) return;

      usersService.update({
        id: this.currentUser.id,
        email: this.email,
        name: this.name,
        address: this.address, 
        photo: this.$refs.photo.files[0],
        phone_number: this.phoneNumber,
      })
        .then((user) => {
          this.setCurrentUser(user);
          this.success = 'Настройки успешно сохранены';
        })
        .catch((error) => this.error = error);
    },
  },
};
</script>

<style scoped>
#photo-hover {
  position: absolute;
  cursor: pointer;
  background: rgb(51, 51, 51, 0.7);
}

input[type="file"] {
  position: absolute;
  top: -500px;
}
</style>

