<template>
  <div class="uk-padding">
    <h1 class="uk-text-center">Obiect scanat</h1>
    <p class="uk-text-center">Nume obiect {{info.name}}</p>
    <p class="uk-text-center">Camera din care provine {{info.room}}</p>
  </div>
</template>

<script>

import { db } from "@/firebase/db.js";

export default {
  name: 'MainPage',
  data() {
    return {
      item: {
        name: String,
        room: Number
      },
      id: Number,
      school: String
    }
  },
  created() {
    this.school = this.$route.params.school;
    console.log(school)
    this.id = this.$route.params.id;
    console.log(id)
  },
  firebase: {
    item: db.ref('Objects').child(school).child(id)
  }
}
</script>

<style scoped lang="scss">

</style>
