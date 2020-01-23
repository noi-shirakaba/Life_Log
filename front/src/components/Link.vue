<template>
<header>
	<v-container>
		<v-row>
			<v-col xl="6" lg="6" md="6" sm="4" cols="4">
				<v-toolbar-title  class="d-inline"><h1 class="pl-3"><router-link to="/home">Life Log</router-link></h1></v-toolbar-title> 
			</v-col>
			<v-col xl="6" lg="6" md="6" sm="6">
				<div class="d-md-flex justify-md-space-around d-sm-flex justify-sm-space-around d-flex justify-space-around" xs12>
					<router-link to="#" class="caption">{{ getName }}</router-link>
					<router-link to="#" class="caption">ヘルプ</router-link>
					<router-link to="/logout" class="caption">ログアウト</router-link>
				</div>
			</v-col>
		</v-row>
	</v-container>
</header>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters('auth', [
      'getName',
    ])
  },
}
</script>

<style scoped>
header {
	border-bottom: 3px solid  var(--maincolor);
}

h1 {
	font-size: 16px;
}

h1 a {
	text-decoration: none;
	color: var(--maincolor);
}

ul {
	font-size: 0;
	list-style: none;
}

li {
	display: inline-block;
	font-size: 10px;
}

li a {
  color: var(--maincolor);
}

a:visited {
  color: var(--maincolor);
}
</style>