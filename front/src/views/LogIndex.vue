<template>
<v-app>
  <IndexLink />
  <Index />
</v-app>
</template>

<script>
import IndexLink from '@/components/Link.vue'
import Index from '@/components/Index.vue'
export default {
  components: {
    IndexLink,
    Index
  }
}
</script>

<style>

</style>