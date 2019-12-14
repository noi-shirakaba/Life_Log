<template>
<div id="app">
  <h1>Top</h1>
  <div id="nav">
    <router-link to="/login">ログイン</router-link> |
    <router-link to="/signup">新規登録</router-link> |

    <router-link to="/home">確認用home</router-link> |
    <router-link to="/form">確認用form</router-link> |
    <router-link to="/index">確認用index</router-link> |
    <router-link to="/show/1">確認用show/1</router-link> |
    <router-link to="/edit/1">確認用edit/1</router-link>
  </div>
  <router-view/>
</div>
</template>