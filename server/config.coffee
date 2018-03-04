# Main config file
# Add everything here, what server code depends on
#


# CHANGE 7777 TO PRODUCTION PORT HERE
appPort = +process.env?.APP_PORT or 7777 # adds options to run dev env on different port.

path        = require("path")
_           = require("lodash")


config =
  appPort: appPort

  # configure database server here. default is nedb
  db: "nedb" # ["nedb", "mongodb"]
  dbPath: "mongodb://localhost:27017/databaseName" # CHANGE TO YOUR MONGO DB NAME
  dbRoot: path.join(__dirname, "../db") # for nedb

  authConfig:
    readOnlyGroups: ["someGroup_r", "anotherGroup_r"]
    readWriteGroups: ["someOtherGroup_rw"]
    # feathers auth config
    secret: "CHANGE ME TO SOMETHING REALLY LONG"
    strategies: ["jwt", "local"]
    path: "/api/authentication"
    service: "api/users"
    jwt:
      header:
        typ: "access"
      audience: "https://yourdomain.com"
      subject: "anonymous"
      issuer: "feathers"
      algorithm: "HS256"
      expiresIn: "1d"
    local:
      entity: "user"
      usernameField: "email"
      passwordField: "password"

  mail:
    server:
      host: 'smtp.yourServerName.at'
      port: 25
  services:
    contacts:
      imageFolder: "/apps/assets/images/contact"
      imageUrl: "/assets/images/contact"


module.exports = (env) ->
  if env is "development"
    development =
      appPort: appPort + 1 # !!! important to make client proxy work
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
