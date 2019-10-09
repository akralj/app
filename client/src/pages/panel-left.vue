<template lang="pug">

f7-page
  f7-block-title Filter by
  f7-list
    f7-list-item(link='/', title='Library', panel-close='')
    f7-list-item(link='/settings/', title='Wishlist', panel-close='')

  f7-block-title Sort by
  f7-list
    f7-list-item(link='/', title='Added', panel-close='')
    f7-list-item(link='/settings/', title='Name', panel-close='')
    f7-list-item(link='/', title='Rating', panel-close='')
    f7-list-item(link='/settings/', title='Year', panel-close='')

  f7-block-title Links
  f7-list
    f7-list-item(link='/', title='Help', panel-close='')
    f7-list-item(link='/settings/', title='Settings', panel-close='')

  f7-block
    p
      | Lorem ipsum dolor sit amet
</template>


<script lang="coffee">

</script>
