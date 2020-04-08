<template>
  <div class="uk-padding">
    <h1 class="uk-text-center">Obiect scanat</h1>
    <p class="uk-text-center">Nume obiect {{info.name}}</p>
    <p class="uk-text-center">Camera din care provine {{info.room}}</p>
  </div>
</template>

<script>
import { db } from '@/firebase/db.js';

export default {
  name: 'MainPage',
  data() {
    return {
      info: null,
      objects: [],
      objectsBySchool: [],
      school: String,
      id: Number
    }
  }, 
  created() {
    school = this.$router.params.school;
    id = this.$router.params.id;
  },
  firebase: {
    objects: db.ref('Objects'),
    objectsBySchool: objects.equalTo(school),
    info: objectsBySchool.equalTo(id).toJSON(),
  },
}
</script>

<style scoped lang="scss">

</style>
