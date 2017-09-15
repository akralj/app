#
#
#

_           = require("lodash-mixins")
npmPackage  = require("./package.json")
appName     = npmPackage.name
appRoot     = "/apps/#{appName}"
appPort     = npmPackage.config.appPort
devServer   = npmPackage.config.devServer
prodServer  = npmPackage.config.prodServer

config =
  appName: appName
  appRoot: appRoot
  appPort: appPort
  serverName: prodServer
  clientCode: "#{appRoot}/server/public"

  # configure database server here. default is nedb in dev & test and mongodb in production
  db:     "mongodb" # ["nedb", "mongodb"]
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
      serverName: devServer
      clientCode: "./client/dist"
      dbRoot: "./db"
      db: "nedb"
    _.merge(config, development)

  else if env is "testing"
    testing=
      serverName: devServer
      appPort:    appPort + 9
      dbRoot:     "./test/db"
      db: "nedb"
    _.merge(config, testing)

  #console.log config
  return config
