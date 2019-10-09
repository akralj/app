<template lang="pug">

//f7-page
  f7-navbar(title='Master Detail', back-link='Back')

f7-page.page-home
  f7-navbar
    f7-nav-left
      f7-link(panel-open='left', icon-ios='f7:menu', icon-aurora='f7:menu', icon-md='material:menu')
    f7-nav-title(sliding='') AppName
    f7-nav-right
      f7-link.searchbar-enable(data-searchbar='.searchbar-components', icon-ios='f7:search', icon-aurora='f7:search', icon-md='material:search')

    f7-searchbar.searchbar-components(search-container='.components-list', search-in='a', expandable='', :disable-button='!this.$theme.aurora')
  
  
  f7-list(media-list)
    //f7-nav-title {{film.name}} ({{film.datePublished}})
    f7-list-item(v-for="film in films", :key="film.id", :reload-detail="true"
      , :link="`/${film.id}/`", :title="film.title", :subtitle="`${film.genre.join(', ')}`")
  //f7-block(strong='')
    p Navigation to/from Master-Detail view happens without transition.
  //f7-list
    f7-list-item(:reload-detail='true', link='/master-detail/1/') Detail Page 1
    f7-list-item(:reload-detail='true', link='/master-detail/2/') Detail Page 2
    f7-list-item(:reload-detail='true', link='/master-detail/3/') Detail Page 3

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
