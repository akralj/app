<template lang="pug">

f7-page.page-home
  f7-navbar
    f7-nav-left
      f7-link(panel-open='left', icon-ios='f7:menu', icon-aurora='f7:menu', icon-md='material:menu')
    f7-nav-title(sliding='') AppName
    f7-nav-right
      f7-link.searchbar-enable(data-searchbar='.searchbar-components', icon-ios='f7:search', icon-aurora='f7:search', icon-md='material:search')
    f7-searchbar.searchbar-components(search-container='.components-list', search-in='a', expandable='', :disable-button='!this.$theme.aurora')
  
  f7-list.components-list.searchbar-found(media-list)
    f7-list-item(v-for="film in films", :key="film.id", :reload-detail="true"
      , :link="`/${film.id}/`", :title="film.title", :subtitle="`${film.genre.join(', ')}`")
  f7-list.searchbar-not-found
    f7-list-item(title='Nothing found')

</template>


<script lang="coffee">

export default(
  data: ->
    films: []
    
  created: ->
    films = @films
    try
      res = await @axios.get("/api/data")
      for film in res.data.data
        film.title = "#{film.name} (#{film.datePublished})"
        films.push(film)
    catch err
      console.log err
)

</script>
