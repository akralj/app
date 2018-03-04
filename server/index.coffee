#
#
#

require("./app").then((app) ->

  port = app.serverConfig.appPort
  server = app.listen(port)
  server.on 'listening', ->
    console.log("Feathers service running on port: #{port}")
).catch (err) -> console.log err
