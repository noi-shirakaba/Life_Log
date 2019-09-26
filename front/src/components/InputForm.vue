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
          <input type="text" v-on:keyup.delete.once="deleteCheckValue" v-model="percent.value" class="form-percent">
        </form>
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
      percents: [{id: 0, value: ""}],
      defaultValue: 0,
      checkValue: 0
    }
  },
  methods: {
    // checkForm(e) {
    //   if (this.percents[checkIndex].value <= 100) {
    //     return true;
    //   }

    //   this.errors = [];

    //   if (this.percents[checkIndex].value >= 101) {
    //     this.errors.push('100%以下にしてください');
    //   }

    //   e.preventDefault();
    // },
    submit(){
      const data = {situation: this.situation};
      axios.post(URL_BASE + 'api/v1/environments', data)
      // .then((_response)=>{console.log(_response)})
    },
    addForm(e){
      const checkIndex = this.percents.length - 1
      this.errors = [];
      if (Number(this.checkValue) + Number(this.percents[checkIndex].value) < 100) {
        this.checkValue = Number(this.checkValue) + Number(this.percents[checkIndex].value)
        let lastIndex = this.percents.slice(-1)[0].id
        lastIndex += 1
        this.percents.push({id: lastIndex, value: ""})
        console.log(this.checkValue)
        return true;
      } else if (Number(this.checkValue) + Number(this.percents[checkIndex].value) === 100) {
        this.checkValue = Number(this.checkValue) + Number(this.percents[checkIndex].value)
        console.log(this.checkValue)
        return true;
      } else {
        this.errors.push('100%以下にしてください');
      }
      console.log(e)
      e.preventDefault();
      // const checkIndex = this.percents.length - 1
      // switch(this.defaultValue) {
      //   case this.defaultValue === 0 && this.checkValue < 100:
      //     this.checkValue = Number(this.checkValue) + Number(this.percents[checkIndex].value)
      //     console.log(this.checkValue)
      //     let lastIndex = this.percents.slice(-1)[0].id
      //     lastIndex += 1
      //     this.percents.push({id: lastIndex, value: 0})
      //     break;
      //   case this.percents[checkIndex].value === 100:
      //     break;
      //   default:
      //     this.checkValue =  Number(this.percents[checkIndex].value)
      //     break;
      // }
      // if (defaultValue === 0 && this.percents[checkIndex].value <= 100 ) {
      //   defaultValue += 1
      //   let checkValue = this.percents[checkIndex].value
      //   console.log(checkValue)
      //   let lastIndex = this.percents.slice(-1)[0].id
      //   lastIndex += 1
      //   this.percents.push({id: lastIndex, value: 0});
      // }else if (checkValue === 100){
      //   checkValue = checkValue + this.percents[checkIndex].value
      //   console.log(checkValue)
      // }else if (checkValue < 100){
      //   checkValue = checkValue + this.percents[checkIndex].value
      //   console.log(checkValue)
      //   let lastIndex = this.percents.slice(-1)[0].id
      //   lastIndex += 1
      //   this.percents.push({id: lastIndex, value: 0});
      // }else {

      // }
    },
    deleteCheckValue() {
      const checkIndex = this.percents.length - 1
      this.checkValue = Number(this.checkValue) - Number(this.percents[checkIndex].value)
      console.log(this.checkValue)
    },
    deleteForm(){
      if (this.percents.length > 1) {
        this.percents.pop();
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
