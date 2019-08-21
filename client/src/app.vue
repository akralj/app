<template lang="pug">
v-app#inspire
  v-navigation-drawer(v-model='drawer', :clipped='$vuetify.breakpoint.lgAndUp', app='', :mobileBreakPoint="900")
    v-list(dense='')
      template(v-for='item in items')
        v-layout(v-if='item.heading', :key='item.heading', align-center='')
          v-flex(xs6='')
            v-subheader(v-if='item.heading')
              | {{ item.heading }}
          v-flex.text-center(xs6='')
            a.body-2.black--text(href='#!') EDIT
        v-list-group(v-else-if='item.children', :key='item.text', v-model='item.model', :prepend-icon="item.model ? item.icon : item['icon-alt']", append-icon='')
          template(v-slot:activator='')
            v-list-item
              v-list-item-content
                v-list-item-title
                  | {{ item.text }}
          v-list-item(v-for='(child, i) in item.children', :key='i', @click='')
            v-list-item-action(v-if='child.icon')
              v-icon {{ child.icon }}
            v-list-item-content
              v-list-item-title
                | {{ child.text }}
        v-list-item(v-else='', :key='item.text', :to="item.link", @click='')
          v-list-item-action
            v-icon {{ item.icon }}
          v-list-item-content
            v-list-item-title
              | {{ item.text }}
  
  v-app-bar(:clipped-left='$vuetify.breakpoint.lgAndUp', app='', color='blue darken-3', dark='')
    v-toolbar-title.ml-0.pl-4(style='width: 300px')
      v-app-bar-nav-icon(@click.stop='drawer = !drawer')
      span.hidden-sm-and-down App Name
    v-text-field.hidden-sm-and-down(flat='', solo-inverted='', hide-details='', prepend-inner-icon='search', label='Search')
    v-spacer
    v-btn(icon='')
      v-icon apps
    v-btn(icon='')
      v-icon notifications


  router-view(:key="$route.path")
  
  v-btn(bottom='', color='pink', dark='', fab='', fixed='', right='', @click='dialog = !dialog')
    v-icon add
  v-dialog(v-model='dialog', width='800px')
    v-card
      v-card-title.grey.darken-2
        | Create contact
      v-container(grid-list-sm='')
        v-layout(wrap='')
          v-flex(xs12='', align-center='', justify-space-between='')
            v-layout(align-center='')
              v-avatar.mr-4(size='40px')
                img(src='//ssl.gstatic.com/s2/oz/images/sge/grey_silhouette.png', alt='')
              v-text-field(placeholder='Name')
          v-flex(xs6='')
            v-text-field(prepend-icon='business', placeholder='Company')
          v-flex(xs6='')
            v-text-field(placeholder='Job title')
          v-flex(xs12='')
            v-text-field(prepend-icon='mail', placeholder='Email')
          v-flex(xs12='')
            v-text-field(type='tel', prepend-icon='phone', placeholder='(000) 000 - 0000')
          v-flex(xs12='')
            v-text-field(prepend-icon='notes', placeholder='Notes')
      v-card-actions
        v-btn(text='', color='primary') More
        v-spacer
        v-btn(text='', color='primary', @click='dialog = false') Cancel
        v-btn(text='', @click='dialog = false') Save

</template>

<script lang="coffee">
import Vue from "vue"
# await test
#f = -> await 13
#f().then (res) -> console.log res


export default(
  data: () -> ({
    dialog: false
    drawer: null
    items: [
      { text: 'Home', icon: 'dashboard'      , link: '/' }
      { text: 'User', icon: 'question_answer', link: '/user' }
      {
        icon: 'keyboard_arrow_up',
        'icon-alt': 'keyboard_arrow_down',
        text: 'More',
        model: false,
        children: [
          { text: 'Import' }
          { text: 'Export' }
        ],
      }
      { icon: 'settings', text: 'Settings' }
      { icon: 'help', text: 'Help' }

    ]
  })
)

</script>


<style lang="stylus">
  
  // print styles. use .no-print class on elements you dont want to show
  @media print
    @page
      margin: 1em
    body
      overflow: auto
      height: auto
    .application--wrap .navigation-drawer, nav.toolbar, .no-print
      display:none
    main.content
      padding: 0 !important
</style>