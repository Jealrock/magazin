<template>
  <v-flex xs12>
    <h3>Фотографии</h3>
    
    <input v-if="uploadReady" type="file" id="photo" ref="photos" v-on:change="handlePhotoUpload()"/>

    <div v-for="(photo, index) in photos">
      <v-hover>
        <v-avatar
          slot-scope="{ hover }"
          :size="84"
          :class="'white'">
          <v-img :src="urlFor(photo)" alt="photo"/>
          <v-fade-transition>
            <v-avatar
              v-if="hover"
              :size="84"
              id="photo-hover"
              @click="removePhoto(index)">
              <div>
                <v-icon class="mt-2"dark>cancel</v-icon><br>
                <span class="white--text">Удалить</span>
              </div>
            </v-avatar>
          </v-fade-transition>
        </v-avatar>
      </v-hover>
    </div>
<v-btn @click="uploadPhoto"> Загрузить фото
    </v-btn>
  </v-flex>
</template>

<script>
export default {
  data: () => ({
    photos: [],
    uploadReady: true
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
      this.uploadReady = false
      this.$nextTick(() => {
        this.uploadReady = true
      });
    },

    removePhoto(index) {
      this.photos.splice(index, 1);
      this.update();
    },

    update() {
      this.$emit('update', this.photos);
    }
  }
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
