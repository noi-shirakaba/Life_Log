<template>
<div class="center">
  <p v-if="errors.length">
    <b>Please correct the following error(s):</b>
    <ul>
      <li v-for="error in errors">{{ error }}</li>
    </ul>
  </p>
  <form @submit.prevent="submit">
    <textarea name="situation" v-model="situation" placeholder="自分にストレスを与えた原因や状態を書いてください"></textarea>
    <button type="submit">submit</button>
  </form>
  <ul>
    <div class="form-group">
      <div class="input-group">
        <button v-on:click="addForm" class="btn btn-primary" type="submit">追加</button>
        <button v-on:click="deleteForm" class="btn btn-primary" type="submit">削除</button>
        <form v-for="percent of percents" :key="percent.id">
          <!-- <input type="text" v-model="newItem" class="form-category"> -->
          <!-- <input type="text" v-on:keyup.delete.once="deleteCheckValue" v-model="percent.value" class="form-percent"> -->
          <input type="text" v-model="percent.value" :key="percent.id" class="form-percent">
        </form>
        <button v-on:click="submitPercents" class="btn btn-primary" type="submit">送信</button>
      </div>
    </div>
  </ul>
</div>
</template>

<script>
import axios from 'axios';

const URL_BASE = process.env.VUE_APP_ORIGIN

export default {
  name: 'Form',
  data(){
    return {
      errors: [],
      situation: '',
      percents: [{id: 0, value: ''}],
    }
  },
  methods: {
    submit(){
      const data = {situation: this.situation}
      axios.post(URL_BASE + 'api/v1/environments', data)
      // .then((_response)=>{console.log(_response)})
    },
    addForm(){
      let lastIndex = this.percents.slice(-1)[0].id
      lastIndex += 1
      this.percents.push({id: lastIndex, value: ""})
      console.log(this.percents)
    },
    deleteForm(){
     if (this.percents.length > 1) {
        this.percents.pop()
      }
    },
    submitPercents(){
      let checkValue = 0
      for (let checkPercent of this.percents) {
        checkValue = checkValue + Number(checkPercent.value)
      }
      if (checkValue > 100) {
        console.log("エラー")
      } else {
        let percentValue = this.percents.map(function( percent ){
          return Number(percent.value)
        })
        console.log(percentValue)
        axios.post(URL_BASE + 'api/v1/emotions_emotion_labels', percentValue)
        console.log("OK")
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
