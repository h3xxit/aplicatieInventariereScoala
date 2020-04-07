<template>
  <div class="uk-padding">
    <h1 class="uk-text-center">Obiect scanat</h1>
    <p class="uk-text-center">Nume obiect {{name}}</p>
    <p class="uk-text-center">Camera din care provine {{room}}</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'MainPage',
  data() {
    return {
      info: {
        id: Number,
        name: String,
        room: String
      }
    }
  }, 
  mounted () {
    /*axios
      .get('linkGet')
      .then(response => (this.info = response))
      .catch(error => this.$router.push({name: "NotFound"}))
    */
  }
}
</script>

<style scoped lang="scss">

</style>
