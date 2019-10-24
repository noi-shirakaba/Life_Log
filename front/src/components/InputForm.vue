<template>
<v-app id="input-form-background">
<h1>ログの入力</h1>
<div class="center">
  <p v-if="this.errorMessages">
    <ul>
      <li v-for="error in errorMessages" id="error">{{ error }}</li>
    </ul>
  </p>
  <h2>環境</h2>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-text-field
      v-model="situation"
      type="text"
      :rules="situationRules"
      :counter="0"
      label="自分にストレスを与えた原因や状態を書いてください"
      required
      outlined
    ></v-text-field>
    <div>
      <v-btn @click="addForm">追加</v-btn>
      <v-btn @click="deleteForm">削除</v-btn>
      <h2>感情や気分</h2>
      <v-text-field
        v-for="category of categorys"
        :key="category.id"
        v-model="category.value"
        :rules="categoryRules"
        required
        outlined
      ></v-text-field>
      <div>
        <h2>数値</h2>
        <v-text-field
          v-for="percent of percents"
          :key="percent.id"
          v-model.number="percent.value"
          :rules="percentRules"
          required
          outlined
        ></v-text-field>
      </div>
    </div>
    <v-btn
      @click="submitPosts"
    >
    送信
    </v-btn>
  </v-form>
</div>
</v-app>
</template>

<script>
import axios from 'axios';

const URL_BASE = process.env.VUE_APP_ORIGIN
const PERCENT_MAX = 100
const CATEGORY_SIZE = 0

export default {
  data(){
    return {
      valid: false,
      situation: '',
      percents: [{id: 0, value: ''}],
      percent: '',
      categorys: [{id: 0, value: ''}],
      category: '',
      situationRules: [
        v => !!v || "Environment is required",
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
    addForm(){
      let lastIndex = this.percents.slice(-1)[0].id
      let lastCategoryIndex = this.categorys.slice(-1)[0].id
      lastIndex += 1
      lastCategoryIndex += 1
      this.percents.push({id: lastIndex, value: ""})
      this.categorys.push({id: lastCategoryIndex, value: ''})
    },
    deleteForm(){
     if (this.percents.length > 1 || this.categorys.length > 1 ) {
        this.percents.pop()
        this.categorys.pop()
      }
    },
    submitPosts() {
      let checkValue = 0
      const situationData = {situation: this.situation}
      for (let checkPercent of this.percents) {
        checkValue = checkValue + Number(checkPercent.value)
      }
      if (this.$refs.form.validate()) {
        if (checkValue === PERCENT_MAX) {
          let percentValue = this.percents.map(function( percent ){
            return Number(percent.value)
          })
          let categoryValue = this.categorys.map(function( category ){
            return category.value
          })
          async function submitFunc() {
            const percentData = {percent: percentValue}
            const categoryData = {category: categoryValue}
            await axios.post(URL_BASE + 'api/v1/environments', situationData).then((_response)=>{console.log(_response)})
            await axios.post(URL_BASE + 'api/v1/emotions_emotion_labels', percentData).then((_response)=>{console.log(_response)})
            await axios.post(URL_BASE + 'api/v1/emotion_labels', categoryData).then((_response)=>{console.log(_response)})
          }
          submitFunc()
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
h1 {
  color: #7b7b7b;
  text-align: center;
}
h2 {
  color: #7b7b7b;
  text-align: left;
}
ul {
  list-style: none;
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
#input-form-background{
  background-color: white;
}
#error {
  color: red;
}
</style>
