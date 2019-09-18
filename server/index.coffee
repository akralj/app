# TODO: should we move users and authentication endpoirnt under /api like all other services??
#
#

schedule  = require('node-schedule')
logger    = require('./logger')

require("./app").then((app) ->
  port = app.serverConfig.appPort
  server = app.listen(port)

  server.on 'listening', ->
    logger.info("Feathers service running on 127.0.0.1:#{port}")

    # kill app every morning to compact nedb
    schedule.scheduleJob { hour: 5, minute: 55 }, () ->
      logger.info("Killed app to compact nedb")
      process.exit()
).catch (err) -> console.log err