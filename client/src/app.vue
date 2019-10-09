<template lang="pug">

f7-app(:params='f7Params')
  f7-panel(left='', cover='', resizable='')
    f7-view(url='/panel-left/', links-view='.view-main')
  //f7-panel(right='', reveal='', resizable='')
    f7-view(url='/panel-right/')
  f7-view.safe-areas(url='/', :main='true', :master-detail-breakpoint='800', :push-state="true", push-state-separator="")

</template>


<script lang="coffee">
  import routes from './routes.coffee'

  export default(
    data: ->
      f7Params:
        id: 'io.framework7.testapp'
        theme: "ios"
        routes: routes
        popup:
          closeOnEscape: true
        sheet:
          closeOnEscape: true
        popover:
          closeOnEscape: true
        actions:
          closeOnEscape: true
  )
</script>


<style lang="stylus">

  // hide back-button on big screens in master-detail view
  .view-master-detail .navbar-master-detail .link.back,
  .view-master-detail .page-master-detail .navbar .link.back
    display: none;

</style>