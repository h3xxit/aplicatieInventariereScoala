<template>
  <div>
    <Navbar />
    <MainPage />
  </div>
</template>

<script>
import MainPage from '@/components/MainPage.vue'
import Navbar from '@/components/Navbar.vue'

export default {
  name: 'Home',
  components: {
    MainPage,
    Navbar
  }
}
</script>
