#
#
#

schedule = require('node-schedule')

require("./app").then (app) ->
  port = app.serverConfig.appPort
  server = app.listen(port)

  server.on 'listening', ->
    app.logger.info("Feathers service running on 127.0.0.1:#{port}")

    # kill app every morning to compact nedb
    schedule.scheduleJob { hour: 5, minute: 55 }, () ->
      app.logger.info("Killed app to compact nedb")
      process.exit()