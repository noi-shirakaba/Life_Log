<template>
<div class="center">
  <form @submit.prevent="submit">
    <textarea name="situation" v-model="situation" placeholder="自分にストレスを与えた原因や状態を書いてください"></textarea>
    <button type="submit">submit</button>
  </form>
  <ul>
    <li v-for="todo in todos">{{ todo }}</li>
  </ul>
  <form v-on:submit.prevent="addItem">
    <div class="form-group">
        <div class="input-group">
            <input type="text" v-model="newItem" class="form-control">
            <span><button class="btn btn-primary" type="submit">送信</button></span>
        </div>
    </div>
  </form>
  <span><button v-on:click="deleteItem">削除</button></span>
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
      newItem: '',
      todos: []
    }
  },
  methods: {
    submit(){
      const data = {situation: this.situation};
      axios.post(URL_BASE + 'api/v1/environments', data)
      // .then((_response)=>{console.log(_response)})
    },
    addItem(){
      this.todos.push(this.newItem);
      this.newItem = '';
      console.log(this.todos.length)
      console.log(this.todos)
      console.log(this.newItem)
    },
    deleteItem(){
      this.todos.pop()
    }
  }
}
</script>

<style>
.center {
  text-align: center;
}

</style>

