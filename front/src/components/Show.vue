<template>
<v-app>
<div id="show">
  <h1 class="show-title">詳細</h1>
  <v-container>
    <h2 class="show-subtitle">◯記録日</h2>
    <h2 v-if="data.environment">{{data.environment.created_at}}</h2>
    <h2 class="show-subtitle">◯環境</h2>
    <h2 v-if="data.environment">{{ data.environment.situation }}</h2>
    <h2 class="show-subtitle">◯ストレス反応</h2>
    <h3 class="category-title">・思考やイメージ</h3>
    <ul v-for="thought in data.thought" :key="thought.id">
      <li>{{thought.thought_content}}</li>
    </ul>
    <h3 class="category-title">・感情や気分</h3>
    <ul v-for="emoLabel in data.emotion_label" :key="`first-${emoLabel.id}`">
      <li>{{emoLabel.category}}</li>
    </ul>
    <ul v-for="emoEmoLabel in data.emotions_emotion_label" :key="`two-${emoEmoLabel.id}`">
      <li>{{emoEmoLabel.percent}}%</li>
    </ul>
    <h3 class="category-title">・身体の反応</h3>
    <ul v-for="reaction in data.reaction" :key="`three-${reaction.id}`">
      <li>{{reaction.content}}</li>
    </ul>
    <h3 class="category-title">・行動</h3>
    <ul v-for="action in data.action" :key="`four-${action.id}`">
      <li>{{action.action_category}}</li>
    </ul>
    <v-btn class="edit-button ma-auto" rounded><router-link :to="{ name: 'Edit', params: { id: payload }}">編集</router-link></v-btn>
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
  data() {
    return {
      payload: this.$route.params.id,
      data: []
    }
  },
  mounted() {
    const payload = this.payload
    axios.get(URL_BASE + 'api/v1/environments/' + payload + '.json', {
      headers: {
        Authorization: `Bearer ${this.getToken}`,
      }
    })
    .then(response => (this.data = response.data))
    // .then((_response)=>{console.log(_response.data)})
    // .then(response => (this.data = response.data))
  },
  computed: {
    ...mapGetters('auth', [
      'getToken',
    ])
  },
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
#show ul {
  list-style: none;
}
#show li {
  margin-left: 100px;
  margin-bottom: 20px;
}
.show-title {
  margin-top: 40px;
}
.category-title {
  color: var(--maincolor);
}
.edit-button a {
  text-decoration: none;
  color: var(--maincolor);
}
.back-button a {
  text-decoration: none;
  color: var(--maincolor);
}
</style>