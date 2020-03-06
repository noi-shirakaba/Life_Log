<template>
<v-app>
  <div id="index">
    <h1 class="index-title">ログ管理一覧</h1>
    <v-container>
      <ul v-for="env in getItems" :key="env.id">
        <h2 class="index-day">◯記録日</h2>
        <li>{{env.created_at}}</li>
        <h2 class="index-situation">◯環境</h2>
        <li><router-link :to="{ name: 'Show', params: { id: env.id }}">{{env.situation}}</router-link></li>
        <hr class="title-line">
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
      <v-row justify="center" class="mt-4">
        <v-btn class="back-button ma-auto" rounded><a @click="$router.go(-1)">戻る</a></v-btn>
      </v-row>
    </v-container>
  </div>
</v-app>
</template>

<script>
import axios from 'axios';
import { mapGetters } from 'vuex'

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
  data(){
    return {
      environments: [],
      parPage: 3,
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

<style scoped>
h1 {
  color: var(--maincolor);
  text-align: center;
}
h2 {
  color: var(--maincolor);
  text-align: left;
  margin-left: 100px;
}
#index ul {
  list-style: none;
}
#index li {
  margin-left: 100px;
  margin-bottom: 20px;
}
.index-title {
  margin-top: 40px;
}
.title-line {
  border-top: 3px solid var(--maincolor);
  margin-top: 40px;
  margin-bottom: 40px;
}
.back-button a {
  text-decoration: none;
  color: var(--maincolor);
}
</style>

