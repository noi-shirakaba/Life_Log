<template>
<div class="center">
  <form @submit.prevent="submitSituations">
    <textarea name="situation" v-model="situation" placeholder="自分にストレスを与えた原因や状態を書いてください"></textarea>
    <button type="submit">submit</button>
  </form>
  <ul>
    <div class="form-group">
      <div class="input-group">
        <button v-on:click="addForm" class="btn btn-primary" type="submit">追加</button>
        <button v-on:click="deleteForm" class="btn btn-primary" type="submit">削除</button>
        <form v-for="percent of percents" :key="percent.id">
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
      situation: '',
      percents: [{id: 0, value: ''}],
      percent: ''
    }
  },
  methods: {
    submitSituations(){
      const data = {situation: this.situation}
      axios.post(URL_BASE + 'api/v1/environments', data)
      // .then((_response)=>{console.log(_response)})
    },
    addForm(){
      let lastIndex = this.percents.slice(-1)[0].id
      lastIndex += 1
      this.percents.push({id: lastIndex, value: ""})
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
      if (checkValue === 100) {
        let percentValue = this.percents.map(function( percent ){
          return Number(percent.value)
        })
        const data = {percent: percentValue}
        axios.post(URL_BASE + 'api/v1/emotions_emotion_labels', data)
        // .then((_response)=>{console.log(_response)})
      } else {
          alert("合計100%になるようにしてください");
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
