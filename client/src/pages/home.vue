<template lang="pug">

v-content
  v-container(fluid='', fill-height='')
    v-layout(align-center='', justify-center='')
      h4 Home, sweet {{myVar}}!
</template>


<script lang="coffee">

export default(
  data: ->
    {
      myVar: "hubdfadfdsa"
    }
)
</script>



<style lang="stylus" scoped>
  h4
    font-size: 1.3em

</style>