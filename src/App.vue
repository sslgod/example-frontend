<template>
  <div id="app">
    <Header/>
    <router-view></router-view>
  </div>
</template>

<script>
import Header from './components/template/Header.vue'

export default {
  name: 'App',
  components: {
    Header
  }
}
</script>
<style>
@tailwind base;

</style>
