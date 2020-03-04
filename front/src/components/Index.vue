<template>
<div class="center">
  <ul v-for="env in getItems" :key="env.id">
    <li><router-link :to="{ name: 'Show', params: { id: env.id }}">{{env.situation}}</router-link></li>
  </ul>
  <v-pagination v-model="currentPage" :length="getPageCount" :total-visible="7">
    <paginate
      :page-range="3"
      :margin-pages="2"
      :click-handler="clickCallback"
      :container-class="'pagination'"
      :page-class="'page-item'">
    </paginate>
  </v-pagination>
</div>
</template>

<script>
import axios from 'axios';
import { mapGetters } from 'vuex'

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
  data(){
    return {
      environments: [],
      parPage: 5,
      currentPage: 1
    }
  },
  computed: {
    ...mapGetters('auth', [
      'getToken',
    ]),
    getItems: function() {
      let current = this.currentPage * this.parPage;
      let start = current - this.parPage;
      return this.environments.slice(start, current);
     },
     getPageCount: function() {
      return Math.ceil(this.environments.length / this.parPage);
     }
  },
  mounted() {
    axios.get(URL_BASE + 'api/v1/environments.json', {
  		headers: {
    		Authorization: `Bearer ${this.getToken}`,
  		}
		})
    .then(response => (this.environments = response.data))
  },
  methods: {
    clickCallback: function (pageNum) {
      this.currentPage = Number(pageNum);
    }
  }
}
</script>

<style>
.center {
  text-align: center;
}

</style>

