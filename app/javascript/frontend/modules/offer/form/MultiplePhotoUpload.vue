<template>
  <div class="photo-upload">
    <h4 class="title font-weight-bold black--text mt-4 mb-4">
      Фотографии
    </h4>

    <input v-if="uploadReady" type="file" id="photo" ref="photos" v-on:change="handlePhotoUpload()" />

    <v-layout row wrap>
      <p class="caption grey--text text--darken-1 mb-1">Не более {{ max }}</p>
    </v-layout>

    <v-container grid-list-md class="pa-0">
      <v-layout row wrap>
        <v-flex xs4 sm2
          v-for="(photo, index) in photos"
          :key="index">
          <v-hover>
            <v-responsive :aspect-ratio="1"
            slot-scope="{ hover }"
            class="grey lighten-3">
              <v-img :src="urlFor(photo)"
                :aspect-ratio="1"
                alt="photo" />
              <v-fade-transition>
                <v-responsive 
                  v-if="hover"
                  :aspect-ratio="1"
                  class="photo-upload__remove-photo-button"
                  @click="removePhoto(index)">
                  <div class="d-flex full_height">
                    <v-icon dark x-large>cancel</v-icon>
                  </div>
                </v-responsive>
              </v-fade-transition>
            </v-responsive>
          </v-hover>
        </v-flex>
        <v-flex xs4 sm2 v-if="photos.length < max">
          <v-hover>
            <v-responsive :aspect-ratio="1"
              slot-scope="{ hover }"
              @click = 'uploadPhoto'
              class="photo-upload__add-photo-button grey lighten-3">
              <div class="d-flex full_height">
                <v-icon light x-large>add_a_photo</v-icon>
              </div>
            </v-responsive>
          </v-hover>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
export default {
  props: {
    max: {
      type: Number,
      default: 10,
    },
  },

  data: () => ({
    photos: [],
    uploadReady: true,
  }),

  methods: {
    uploadPhoto() {
      this.$refs.photos.click();
    },

    urlFor(photo) {
      return URL.createObjectURL(photo);
    },

    handlePhotoUpload() {
      this.photos = this.photos.concat(Array.from(this.$refs.photos.files));
      this.update();
      // rerender native element to clear file
      this.uploadReady = false;
      this.$nextTick(() => {
        this.uploadReady = true;
      });
    },

    removePhoto(index) {
      this.photos.splice(index, 1);
      this.update();
    },

    update() {
      this.$emit('update', this.photos);
    },
  },
};
</script>

<style scoped>
.photo-upload__remove-photo-button {
  position: absolute;
  cursor: pointer;
  top: 0;
  width: 100%;
  background: rgba(0, 0, 0, .5);
}

.photo-upload__add-photo-button {
  cursor: pointer;
}

.full_height {
  height: 100%;
}

input[type="file"] {
  position: absolute;
  top: -500px;
}
</style>
