#
#
#



module.exports = ->
  app = this

  # add all methods which you want to expose here
  require("./methods/test")(app)
