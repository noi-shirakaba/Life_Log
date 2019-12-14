<template>
<v-app id="home-background">
	<HomeLink/>
	<HomeButton />
</v-app>
</template>

<script>
import HomeLink from '@/components/Link.vue'
import HomeButton from '@/components/HomeButton.vue'

export default {
	components: {
		HomeLink,
		HomeButton
	},
}
</script>

<style scoped>
#home-background {
	background-color: white;
}
</style>