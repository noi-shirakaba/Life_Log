<template>
	<v-app>
		<EditLink />
		<Edit/>
	</v-app>
</template>

<script>
import EditLink from '@/components/Link.vue'
import Edit from '@/components/Edit.vue'
export default {
	components: {
    EditLink,
    Edit
  }
}
</script>

<style scoped>

</style>