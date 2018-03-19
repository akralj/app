#
#
#

schedule = require('node-schedule')
createUuid = -> require('uuid').v4().replace(/\-/ig, '')

module.exports = ->
  app = this
  logs = app.service("/api/logs")
  getData = require("./getData")

  # 1. get all people
  schedule.scheduleJob { hour: 22, minute: 0 }, () ->
    result = await getData({ app: app })
    console.log "did important work", result

  result = await getData({ app: app })
  console.log "did important work", result
  ###
  # add this if you want logs under /api/logs
  #logs = app.service("/api/logs")
  try
    #logItem = await logs.get("36692")
    logItem = await logs.create({ messsage: "3. one", level: "info", event: "1 test event" })
    console.log "RESULT:", logItem
  catch err
    console.log "TEST ERROR", Object.keys err.hook.data
  ###
