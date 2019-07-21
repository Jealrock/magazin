<template>
  <footer class="footer">
    <v-container class="pa-0 px-3 py-3">
      <v-layout row wrap align-center justify-space-between>
        <v-flex xs6>
          <p class="body-1 mb-0 link_grey">
            Почта создателя сервиса<br>
            <span class="info--text">way_yurt@mail.ru</span>
          </p>
        </v-flex>

        <v-flex xs3>
          <a href="https://megakassa.ru/" title="Платежный агрегатор Мегакасса" style="float: right;" target="_blank">
            <img src="https://megakassa.ru/pr/light_ru.jpg" alt="Megakassa" />
          </a>
        </v-flex>
      </v-layout>
    </v-container>
  </footer>
</template>

<style scoped>
.footer {
  background-color: #f7f7f7;
}
</style>
