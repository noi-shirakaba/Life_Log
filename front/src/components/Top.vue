<template>
<div id="top">
  <h1>Top</h1>
  <div id="nav">
    <router-link to="/login">ログイン</router-link> |
    <router-link to="/signup">新規登録</router-link>
  </div>
  <router-view/>
</div>
</template>