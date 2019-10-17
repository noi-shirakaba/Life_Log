<template>
<div class="center">
  <form>
    <textarea name="situation" v-model="situation" placeholder="自分にストレスを与えた原因や状態を書いてください"></textarea>
  </form>
  <ul>
    <div class="form-group">
      <div class="input-group">
        <button v-on:click="addForm" class="btn btn-primary" type="submit">追加</button>
        <button v-on:click="deleteForm" class="btn btn-primary" type="submit">削除</button>
        <form v-for="category of categorys" :key="category.id">
          <input type="text" v-model="category.value" :key="category.id" class="form-category">
        </form>
        <div>
          <form v-for="percent of percents" :key="percent.id">
            <input type="text" v-model="percent.value" :key="percent.id" class="form-percent">
          </form>
        </div>
        <button v-on:click="submitPosts" class="btn btn-primary" type="submit">送信</button>
      </div>
    </div>
  </ul>
</div>
</template>

<script>
import axios from 'axios';

const URL_BASE = process.env.VUE_APP_ORIGIN
const PERCENT_MAX = 100
const PERCENT_MIN = 0

export default {
  data(){
    return {
      situation: '',
      percents: [{id: 0, value: ''}],
      percent: '',
      categorys: [{id: 0, value: ''}],
      category: ''
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
    submitPosts(){
      let checkValue = 0
      const situationData = {situation: this.situation}
      for (let checkPercent of this.percents) {
        checkValue = checkValue + Number(checkPercent.value)
      }
      if (checkValue === 100 && this.categorys.length > 0) {
        console.log(this.categorys.length)
        let percentValue = this.percents.map(function( percent ){
          return Number(percent.value)
        })
        let categoryValue = this.categorys.map(function( category ){
          console.log(category.value)
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
      } else {
        alert("合計100%になるようにするか、カテゴリーを入力してください。");
      }
    }
  }
}
</script>

<style scoped>
.center {
  text-align: center;
}
.form-category {
  background-color: #f6f6f6;
}
.form-percent {
  background-color: aquamarine;
}
</style>
