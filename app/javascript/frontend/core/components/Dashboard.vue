<template>
  <div>
    <AppHeader/>
    <v-container class="pa-0">
      <v-layout>
        <v-flex sm12>
          <nav class="nav services__nav">
            <a class="nav__link" href="#">Авто</a>
            <a class="nav__link" href="#">Недвижимость</a>
            <a class="nav__link" href="#">Работа</a>
            <a class="nav__link" href="#">Услуги</a>
            <a class="nav__link" href="#">ещё...</a>
          </nav>
        </v-flex>
      </v-layout>
      <v-layout>
        <v-flex sm12>
          <SearchGroup /> 
        </v-flex>
      </v-layout>
      <v-layout>
        <v-flex sm12>
          <Gallery title="VIP-объявления"
                   :itemsInRow="3" />
        </v-flex>
      </v-layout>
      <v-layout>
        <v-flex sm12>
          <Gallery title="Новые объявления" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import AppHeader from '@frontend/core/components/AppHeader';
import SearchGroup from '@frontend/core/components/SearchGroup';
import Gallery from '@frontend/core/components/gallery/Gallery';

export default {
  components: {
    AppHeader, SearchGroup, Gallery
  }
}
</script>
