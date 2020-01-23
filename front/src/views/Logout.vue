<template>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data() {
    return {
    }
  },
  mounted() {
    this.onLogout()
  },
  methods: {
    ...mapActions('auth', [
      'logout'
    ]),

    onLogout() {
      this.logout()
      this.$router.push('/login/out')
    }
  }
}
</script>