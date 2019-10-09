<template lang="pug">

f7-page.page-home
  f7-navbar
    f7-nav-left
      f7-link(panel-open='left', icon-ios='f7:menu', icon-aurora='f7:menu', icon-md='material:menu')
    f7-nav-title(sliding='') Framework7 Vue
    f7-nav-right
      f7-link.searchbar-enable(data-searchbar='.searchbar-components', icon-ios='f7:search', icon-aurora='f7:search', icon-md='material:search')
    f7-nav-title-large Framework7 Vue
    f7-searchbar.searchbar-components(search-container='.components-list', search-in='a', expandable='', :disable-button='!this.$theme.aurora')
  f7-block-title.searchbar-found(medium='') Components
  f7-list.components-list.searchbar-found
    f7-list-item(title='Master-Detail (Split View)', link='/master-detail/')
  f7-list.searchbar-not-found
    f7-list-item(title='Nothing found')
</template>


<script>

</script>
