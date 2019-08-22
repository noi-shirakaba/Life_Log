<template>
  <div id="app">
    <Form></Form>
    <Index></Index>
  </div>
</template>

<script>
import Form from './components/form.vue'
import Index from './components/index.vue'

export default {
  name: 'App',
  components: {
    Form,
    Index
  }
}
</script>
