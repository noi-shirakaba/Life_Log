<template>
<v-app>
  <ShowLink />
  <Show />
</v-app>
</template>

<script>
import ShowLink from '@/components/Link.vue'
import Show from '@/components/Show.vue'
export default {
  components: {
    ShowLink,
    Show
  }
}
</script>

<style scoped>

</style>