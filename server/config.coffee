#
#
#

_           = require("lodash-mixins")
appName     = require("./package.json").name
appRoot     = "/apps/#{appName}"

# adds options to run dev env on different port. (two people can dev on same server)
appPort = if process.env?.APP_PORT then +process.env.APP_PORT else appPort = 7777 # this is production port


config =
  appName: appName
  appRoot: appRoot
  appPort: appPort
  clientCode: "#{appRoot}/server/public"

  # configure database server here. default is nedb in dev & test and mongodb in production
  db: "nedb" # ["nedb", "mongodb"]
  dbPath: "mongodb://localhost:27017"
  dbRoot: "#{appRoot}/db" # for nedb

  authConfig:
    readOnlyGroups: ["someGroup_r", "anotherGroup_r"]
    readWriteGroups: ["someOtherGroup_rw"]
  mail:
    server:
      host: 'smtp.yourServerName.at'
      port: 25
    templatesPath: "#{appRoot}/share/templatesDir"

  services:
    contacts:
      imageFolder: "/apps/assets/images/contact"
      imageUrl: "/assets/images/contact"


module.exports = (env) ->
  if env is "development"
    development =
      appPort: appPort + 1 # !!! important to make client proxy work
      clientCode: "./server/public"
      dbRoot: "./db"
      db: "nedb"
    _.merge(config, development)

  else if env is "testing"
    testing=
      appPort: appPort + 2
      dbRoot: "./test/db"
      db: "nedb"
    _.merge(config, testing)

  #console.log config
  return config
