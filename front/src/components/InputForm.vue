<template>
<v-app id="input-form-background">
<h1 class="input-title">ログの入力</h1>
<p v-if="this.errorMessages" class="text-center pt-3">
  <ul>
    <li v-for="error in errorMessages" id="error" :key="error">{{ error }}</li>
  </ul>
</p>
<v-container>
    <h2>環境</h2>
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-row>
          <v-col>
            <v-text-field
              v-model="situation"
              type="text"
              :rules="situationRules"
              :counter="0"
              label="自分にストレスを与えた原因や状態を書いてください"
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
              type="text"
              label="ストレスを感じた時の身体の反応を書いてください"
              required
              outlined
            ></v-text-field>
          </v-col>
          <v-col md="2" sm="4">
            <v-btn fab class="add-button mr-4"><v-icon dark>mdi-plus</v-icon></v-btn>
            <v-btn fab class="delete-button"><v-icon dark>mdi-minus</v-icon></v-btn>
          </v-col>
        </v-row>
        <h2>行動</h2>
        <v-row>
          <v-col md="10" sm="8" cols="12">
            <v-text-field
              type="text"
              label="ストレスが起きた時どんな行動を行ったかを書いてください"
              required
              outlined
            ></v-text-field>
          </v-col>
          <v-col md="2" sm="4">
            <v-btn fab class="add-button mr-4"><v-icon dark>mdi-plus</v-icon></v-btn>
            <v-btn fab class="delete-button"><v-icon dark>mdi-minus</v-icon></v-btn>
          </v-col>
        </v-row>
        <v-row justify="center">
          <v-btn
            class="submit-button"
            rounded
            @click="submitPosts"
          >
          保存
          </v-btn>
        </v-row>
      </v-form>
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
  data(){
    return {
      valid: false,
      situation: '',
      envID: '',
      thoughts: [{id: 0, value: ''}],
      thought: '',
      percents: [{id: 0, value: ''}],
      percent: '',
      categorys: [{id: 0, value: ''}],
      category: '',
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
      errorMessages: [
      ]
    }
  },
  methods: {
    addEmotionForm(){
      let lastIndex = this.percents.slice(-1)[0].id
      let lastCategoryIndex = this.categorys.slice(-1)[0].id
      lastIndex += 1
      lastCategoryIndex += 1
      this.percents.push({id: lastIndex, value: ""})
      this.categorys.push({id: lastCategoryIndex, value: ''})
    },
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
    deleteEmotionForm(){
      if (this.percents.length > 1 || this.categorys.length > 1 ) {
        this.percents.pop()
        this.categorys.pop()
      }
    },
    async submitFunc(situationValue, thoughtValue, percentValue, categoryValue) {
      const config = {headers: {Authorization: `Bearer ${this.getToken}`,}}
      await axios.post(URL_BASE + 'api/v1/environments', situationValue, config).then(_response =>(this.envID = _response.data.id))
      const categoryData = {id: Number(this.envID), category: categoryValue}
      await axios.post(URL_BASE + 'api/v1/emotion_labels', categoryData, config).then(_response =>(this.emoID = _response.data))
      const percentData = {emotion_id: Number(this.emoID.emotion.id), emotion_label_id: this.emoID.emotion_label.map(Number), percent: percentValue}
      await axios.post(URL_BASE + 'api/v1/emotions_emotion_labels', percentData, config).then((_response)=>{console.log(_response)})
      const thoughtData = {id: Number(this.envID), thought_content: thoughtValue}
      await axios.post(URL_BASE + 'api/v1/thoughts', thoughtData, config).then((_response)=>{console.log(_response)})
    },
    submitPosts() {
      let checkValue = 0
      const situationData = {situation: this.situation}
      for (let checkPercent of this.percents) {
        checkValue = checkValue + Number(checkPercent.value)
      }
      if (this.$refs.form.validate()) {
        let thoughtValue = this.thoughts.map(function( thought ){
          return thought.value
        })
        if (checkValue === PERCENT_MAX) {
          let percentValue = this.percents.map(function( percent ){
            return Number(percent.value)
          })
          let categoryValue = this.categorys.map(function( category ){
            return category.value
          })
          this.submitFunc(situationData, thoughtValue, percentValue, categoryValue)
          this.errorMessages.pop()
        }else{
          this.errorMessages.pop()
          this.errorMessages.push('Please make sure the sum of the numbers is 100percent')
        }
      }else{
        this.errorMessages.pop()
        this.errorMessages.push('There are unfilled items or values ​​that are not valid.')
      }
    }
  }
}
</script>

<style scoped>
#input-form-background{
  background-color: white;
}
#error {
  color: red;
}
h1 {
  color: var(--maincolor);
  text-align: center;
}
h2 {
  color: var(--maincolor);
  text-align: left;
}
ul {
  list-style: none;
}
.title-line {
  border-top: 3px solid var(--maincolor);
  margin-top: 40px;
  margin-bottom: 40px;
}
.input-title{
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
