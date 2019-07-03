<template lang="pug">

v-content
  v-container
    v-layout(row)
      h4 Home, sweet {{myVar}}!
</template>


<script lang="coffee">

export default(
  data: ->
    {
      myVar: "home"
    }
)
</script>



<style lang="stylus" scoped>
  h4
    font-size: 1.3em

</style>