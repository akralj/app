<template lang="pug">

f7-page
  f7-navbar(:title="title" back-link="Back")
  f7-card(outline, style="text-align: center")
    //f7-card-header(style="justify-content: center; font-weight: 500") {{title}}
    
    f7-card-content()
      img(:src="film.imageUrl", height=200)
      p(style="text-align: left") {{film.description}}
    f7-card-footer
      a.link(href="#") Trailer
      a.link.external(:href="'https://www.imdb.com/title/tt'+ film.id", target="_newtab") IMDB
      a.link(href="#", @click="addFilmToCol()") Add to Collection

</template>


<script lang="coffee">

export default(
  data: ->
    film: {}
  
  computed:
    filmId: -> @$f7route.params.id
    title: -> "#{@film.name} (#{@film.datePublished})"

  methods:
    addFilmToCol: ->
  
  created: ->
    try
      res = await @axios.get("/api/data/#{@filmId}")
      @film = res.data
    catch err
      console.log err
)

</script>


<style lang="stylus">

// throws error when emtpy

</style>