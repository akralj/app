<template lang="pug">

f7-page
  f7-navbar(:title='`Detail Page ${$f7route.params.id}`', back-link='Back')

  f7-block(strong='')
    p
      b Detail Page {{$f7route.params.id}}
    p
      | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque congue turpis et risus fringilla condimentum. Aliquam vestibulum est tempor, sagittis massa nec, dictum massa. Phasellus non viverra dui, eget aliquam sem. Donec eleifend dolor id arcu ultrices, vel ultrices dolor fringilla. Phasellus feugiat consectetur libero, eget luctus felis rhoncus at. Duis scelerisque ligula sit amet purus congue pulvinar. Proin a risus id nibh fermentum auctor. Vestibulum at sem a risus mollis iaculis. In vestibulum malesuada arcu id consectetur.

</template>


<script lang="coffee">

</script>


<style lang="stylus">

  // hide back-button on big screens in master-detail view
  .view-master-detail .navbar-master-detail .link.back,
  .view-master-detail .page-master-detail .navbar .link.back
    display: none;

</style>