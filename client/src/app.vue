<template lang="pug">

v-app#inspire
  v-navigation-drawer(app, fixed, v-model='drawer', :mobileBreakPoint="900")
    v-list()
      v-list-tile(@click='')
        v-list-tile-avatar
          img(src="https://randomuser.me/api/portraits/men/85.jpg")
        v-list-tile-content
          v-list-tile-title Titel
    v-list.pt-0
      v-divider
      v-list-tile(v-for="item in menuItems", :key="item.title", :to="item.link")
        v-list-tile-action
          v-icon {{ item.icon }}
        v-list-tile-content
          v-list-tile-title {{ item.title }}

  v-toolbar.indigo(dark, fixed, app)
    v-toolbar-side-icon(@click.stop='drawer = !drawer')
    v-toolbar-title {{$route.name}}

  router-view(:key="$route.path")

</template>


<script lang="coffee">

exports.default =
  data: ->
    {
      drawer: true
      menuItems: [
        { title: 'Home', icon: 'dashboard'      , link: '/' }
        { title: 'User', icon: 'question_answer', link: '/user' }
      ]
      mini: false
      right: null
    }

</script>


<style src='vuetify/dist/vuetify.min.css'></style>
<style lang="stylus">
  //@import './stylus/main'
</style>
