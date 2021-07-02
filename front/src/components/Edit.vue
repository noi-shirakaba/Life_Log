<template>
<v-app id="edit-form-background">
  <h1 class="edit-title">ログの編集</h1>
  <div class="text-center">
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <template v-slot:activator="{ on }">
        <v-btn
          color="red lighten-2"
          dark
          v-on="on"
        >
          削除
        </v-btn>
      </template>

      <v-card>
        <v-card-title
          class="headline grey lighten-2"
          primary-title
        >
          注意！
        </v-card-title>

        <v-card-text>
          ここにある全てのコンテンツを完全削除しますがよろしいでしょうか？※項目ごとの削除ではないのでご注意ください！
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="primary"
            text
            @click="deleteLog"
          >
            削除する
          </v-btn>
          <v-btn
            color="primary"
            text
            @click="dialog = false"
          >
            戻る
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
  <p v-if="this.errorMessages" class="text-center pt-3">
    <ul>
      <li v-for="error in errorMessages" id="error" :key="error">{{ error }}</li>
    </ul>
  </p>
  <v-container>
    <form @submit.prevent="submit">
  </form>
      <h2>環境</h2>
      <v-row>
        <v-col>
          <v-text-field
              v-if="data.environment"
              v-model="data.environment.situation"
              type="text"
              :counter="0"
              :rules="situationRules"
              required
              outlined
          ></v-text-field>
        </v-col>
      </v-row>
      <hr class="title-line">
      <h1 class="reaction-title">ストレスの反応</h1>
      <h2>思考やイメージ</h2>
        <v-row>
          <v-col md="10" sm="8" cols="12">
            <v-text-field
              label="ストレスを感じた時の思考や浮かんだ言葉などを書いてください"
              :counter="0"
              v-for="thought of thoughts"
              :key="thought.id"
              v-model="thought.value"
              type="text"
              :rules="thoughtRules"
              required
              outlined
            ></v-text-field>
          </v-col>
          <v-col md="2" sm="4">
            <v-btn @click="addThoughtForm" fab class="add-button mr-4"><v-icon dark>mdi-plus</v-icon></v-btn>
            <v-btn @click="deleteThoughtForm" fab class="delete-button"><v-icon dark>mdi-minus</v-icon></v-btn>
          </v-col>
        </v-row>
      <h2>感情や気分</h2>
        <v-row>
          <v-col md="8" sm="6" cols="12">
            <v-text-field
            　label="ストレスを感じた時の感情や気分を書いてください"
              v-for="category of categorys"
              :key="category.id"
              v-model="category.value"
              :rules="categoryRules"
              required
              outlined
            ></v-text-field>
          </v-col>
          <v-col md="2" sm="2" cols="12">
            <v-text-field
              label="数値を入力してください"
              v-for="percent of percents"
              :key="percent.id"
              v-model.number="percent.value"
              :rules="percentRules"
              required
              outlined
            ></v-text-field>
          </v-col>
          <v-col md="2" sm="4">
            <v-btn @click="addEmotionForm" fab class="add-button mr-4"><v-icon dark>mdi-plus</v-icon></v-btn>
            <v-btn @click="deleteEmotionForm" fab class="delete-button"><v-icon dark>mdi-minus</v-icon></v-btn>
          </v-col>
        </v-row>
      <h2>身体の反応</h2>
      <v-row>
        <v-col md="10" sm="8" cols="12">
          <v-text-field
            label="ストレスを感じた時の身体の反応を書いてください"
            :counter="0"
            v-for="reaction of reactions"
            :key="reaction.id"
            v-model="reaction.value"
            type="text"
            :rules="reactionRules"
            required
            outlined
          ></v-text-field>
        </v-col>
        <v-col md="2" sm="4">
          <v-btn @click="addReactionForm" fab class="add-button mr-4"><v-icon dark>mdi-plus</v-icon></v-btn>
          <v-btn @click="deleteReactionForm" fab class="delete-button"><v-icon dark>mdi-minus</v-icon></v-btn>
        </v-col>
      </v-row>
      <h2>行動</h2>
          <v-row>
            <v-col md="10" sm="8" cols="12">
              <v-text-field
                label="ストレスが起きた時どんな行動を行ったかを書いてください"
                :counter="0"
                v-for="action of actions"
                :key="action.id"
                v-model="action.value"
                type="text"
                :rules="actionRules"
                required
                outlined
              ></v-text-field>
            </v-col>
            <v-col md="2" sm="4">
              <v-btn @click="addActionForm" fab class="add-button mr-4"><v-icon dark>mdi-plus</v-icon></v-btn>
              <v-btn @click="deleteActionForm" fab class="delete-button"><v-icon dark>mdi-minus</v-icon></v-btn>
            </v-col>
          </v-row>
          <v-row justify="center">
          <v-btn
            class="submit-button"
            rounded
            @click="submitUpdate"
          >
          保存
          </v-btn>
        </v-row>
      <v-row justify="center" class="mt-4">
        <v-btn class="back-button ma-auto" rounded><a @click="$router.go(-1)">戻る</a></v-btn>
      </v-row>
  </v-container>
</v-app>
</template>

<script>
import axios from 'axios';
import { mapGetters } from 'vuex'

const URL_BASE = process.env.VUE_APP_ORIGIN
const PERCENT_MAX = 100
const CATEGORY_SIZE = 0

export default {
   computed: {
    ...mapGetters('auth', [
      'getToken',
    ])
  },
  data() {
    return {
      valid: false,
      dialog: false,
      payload: this.$route.params.id,
      data: [],
      thoughts: [{id: '', value: ''}],
      categorys: [{id: 0, value: ''}],
      percents: [{id: 0, value: ''}],
      reactions: [{id: 0, value: ''}],
      actions: [{id: 0, value: ''}],
      situationRules: [
        v => !!v || "Environment is required",
        v => v.length >= 3 || "Please write at least 3 characters"
      ],
      thoughtRules: [
        v => !!v || "Thoughts is required",
        v => v.length >= 3 || "Please write at least 3 characters"
      ],
      categoryRules: [
        v => !!v || "Emotion or mood is required"
      ],
      percentRules: [
        v => !!v || "Percent is required",
        v => typeof v == "number" || "Please enter only numbers",
        v => v >= 10 || "Please enter a value greater than 10percent",
        v => v <= 100 || "You can enter up to 100percent at a time",
      ],
      actionRules: [
        v => !!v || "Actions is required",
        v => v.length >= 3 || "Please write at least 3 characters"
      ],
      reactionRules: [
        v => !!v || "Reactions is required",
        v => v.length >= 3 || "Please write at least 3 characters"
      ],
      errorMessages: [
      ]
    }
  },
  mounted() {
    const payload = this.payload
    axios.get(URL_BASE + 'api/v1/environments/' + payload + '.json', {
      headers: {
        Authorization: `Bearer ${this.getToken}`,
      }
    })
    .then(response => {
      this.data = response.data
      console.log(this.data)
      this.thoughts.shift()
      this.categorys.shift()
      this.percents.shift()
      this.reactions.shift()
      this.actions.shift()
      this.thoughtGet(this.data)
      this.categoryGet(this.data)
      this.parcentGet(this.data)
      this.reactionGet(this.data)
      this.actionGet(this.data)
    })
  },
  computed: {
    ...mapGetters('auth', [
      'getToken',
    ])
  },
  methods: {
    addThoughtForm(){
      let lastThoughtIndex = this.thoughts.slice(-1)[0].id
      lastThoughtIndex += 1
      this.thoughts.push({id: lastThoughtIndex, value: ""})
    },
    deleteThoughtForm(){
      if (this.thoughts.length > 1) {
        this.thoughts.pop()
      }
    },
   addEmotionForm(){
      let lastIndex = this.percents.slice(-1)[0].id
      let lastCategoryIndex = this.categorys.slice(-1)[0].id
      lastIndex += 1
      lastCategoryIndex += 1
      this.percents.push({id: lastIndex, value: ""})
      this.categorys.push({id: lastCategoryIndex, value: ''})
    },
    deleteEmotionForm(){
        if (this.percents.length > 1 || this.categorys.length > 1 ) {
        this.percents.pop()
        this.categorys.pop()
      }
    },
    addReactionForm(){
      let lastReactionIndex = this.reactions.slice(-1)[0].id
      lastReactionIndex += 1
      this.reactions.push({id: lastReactionIndex, value: ""})
    },
    deleteReactionForm(){
      if (this.reactions.length > 1) {
        this.reactions.pop()
      }
    },
    addActionForm(){
      let lastActionIndex = this.actions.slice(-1)[0].id
      lastActionIndex += 1
      this.actions.push({id: lastActionIndex, value: ""})
    },
    deleteActionForm(){
      if (this.actions.length > 1) {
        this.actions.pop()
      }
    },
    thoughtGet: function(data) {
      data.thought.forEach((value) => {
        this.thoughts.push({id: value.id, value: value.thought_content})
      })
    },
    categoryGet: function(data) {
      data.emotion_label.forEach((value) => {
        this.categorys.push({id: value.id, value: value.category})
      })
    },
    parcentGet: function(data) {
      data.emotions_emotion_label.forEach((value) => {
        this.percents.push({id: value.id, value: value.percent})
      })
    },
    reactionGet: function(data) {
      data.reaction.forEach((value) => {
        this.reactions.push({id: value.id, value: value.content})
      })
    },
    actionGet: function(data) {
      data.action.forEach((value) => {
        this.actions.push({id: value.id, value: value.action_category})
      })
    },
    // submit(){
    //   let checkValue = 0
    //   const situationData = {situation: this.situation}
    //   for (let checkPercent of this.percents) {
    //     checkValue = checkValue + Number(checkPercent.value)
    //   }
    //   if (this.$refs.form.validate()) {
    //     let thoughtValue = this.thoughts.map(function( thought ){
    //       return thought.value
    //     })
    //     let actionValue = this.actions.map(function( action ){
    //       return action.value
    //     })
    //     let reactionValue = this.reactions.map(function( reaction ){
    //       return reaction.value
    //     })
    //     if (checkValue === PERCENT_MAX) {
    //       let percentValue = this.percents.map(function( percent ){
    //         return Number(percent.value)
    //       })
    //       let categoryValue = this.categorys.map(function( category ){
    //         return category.value
    //       })
    //       this.submitFunc(situationData, thoughtValue, percentValue, categoryValue, actionValue, reactionValue)
    //       this.errorMessages.pop()
    //     }else{
    //       this.errorMessages.pop()
    //       this.errorMessages.push('Please make sure the sum of the numbers is 100percent')
    //     }
    //   }else{
    //     this.errorMessages.pop()
    //     this.errorMessages.push('There are unfilled items or values ​​that are not valid.')
    //   }
    // },
    async submitUpdate(){
      console.log("update")
      console.log(this.categorys)
      console.log(this.percents)
      const payload = this.payload
      const data = {situation: this.data.environment.situation}
      let thoughtValue = this.thoughts.map(function( thought ){
          return thought.value
        })
      let actionValue = this.actions.map(function( action ){
          return action.value
        })
      let reactionValue = this.reactions.map(function( reaction ){
          return reaction.value
        })
      let percentValue = this.percents.map(function( percent ){
            return Number(percent.value)
          })
      let categoryValue = this.categorys.map(function( category ){
            return category.value
          })
      const thoughtData = {id: payload, thought_content: thoughtValue}
      const actionData = {id: payload, action_category: actionValue}
      const reactionData = {id: payload, content: reactionValue}
      const categoryData = {id: payload, category: categoryValue}
      const percentData = {percent: percentValue}
      const config = {headers: {Authorization: `Bearer ${this.getToken}`,}}
      await axios.put(URL_BASE + 'api/v1/environments/' + payload, data, config)
      .then((_response)=>{console.log(_response)})
      await axios.put(URL_BASE + 'api/v1/thoughts/' + payload, thoughtData, config)
      .then((_response)=>{console.log(_response)})
      await axios.put(URL_BASE + 'api/v1/actions/' + payload, actionData, config)
      .then((_response)=>{console.log(_response)})
      await axios.put(URL_BASE + 'api/v1/reactions/' + payload, reactionData, config)
      .then((_response)=>{console.log(_response)})
      await axios.put(URL_BASE + 'api/v1/emotion_labels/' + payload, categoryData, config)
      .then((_response)=>{console.log(_response)})
      await axios.put(URL_BASE + 'api/v1/emotions_emotion_labels/' + payload, percentData, config)
      .then((_response)=>{console.log(_response)})
    },
    deleteLog(){
      this.dialog = false
      const payload = this.payload
      console.log(payload)
      axios.delete(URL_BASE + 'api/v1/environments/' + payload, {
        headers: {
          Authorization: `Bearer ${this.getToken}`,
        }
      })
      .then((_response)=>{console.log(_response)})
      this.$router.push({ path: '/index' })
      this.$router.go({ path: '/index' })
    }
  }
}
</script>

<style scoped>
#edit-form-background{
  background-color: white;
}
h1 {
  color: var(--maincolor);
  text-align: center;
}
h2 {
  color: var(--maincolor);
  text-align: left;
}
#error {
  color: red;
}
.title-line {
  border-top: 3px solid var(--maincolor);
  margin-top: 40px;
  margin-bottom: 40px;
}
.edit-title{
  margin-top: 40px;
}
.reaction-title {
  margin-bottom: 47px;
}
.center {
  text-align: center;
}
.form-category {
  background-color: #f6f6f6;
}
.form-percent {
  background-color: aquamarine;
}
.add-button {
  color: var(--maincolor);
}
.delete-button {
  color: var(--maincolor);
}
.submit-button {
  color: var(--maincolor);
  width: 250px;
}
.back-button a {
  text-decoration: none;
  color: var(--maincolor);
}
</style>