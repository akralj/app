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
  mail:
    server:
      host: 'smtp.yourServerName.at'
      port: 25
  services:
    contacts:
      imageFolder: "/apps/assets/images/contact"
      imageUrl: "/assets/images/contact"


  authentication:
    "entity": "user",
    "service": "users",
    "secret": "0EuWRCdfaTtF4Atpi8DHbhPoFu4=",
    "authStrategies": [
      "jwt",
      "local"
    ],
    "jwtOptions":
      "header":
        "typ": "access"

      "audience": "https://yourdomain.com",
      "issuer": "feathers",
      "algorithm": "HS256",
      "expiresIn": "1d"
    "local":
      "usernameField": "email",
      "passwordField": "password"
    "oauth":
      "redirect": "/",
      "github":
        "key": "<github oauth key>",
        "secret": "<github oauth secret>"


module.exports = (env) ->
  if env is "development"
    development =
      appPort: appPort
      db: "nedb"
    _.merge(config, development)
  
  else if env is "staging"
    staging =
      appPort: appPort + 1
      dbRoot: "./test/db"
      db: "nedb"
    _.merge(config, staging)

  else if env is "testing"
    testing=
      appPort: appPort + 2
      dbRoot: "./test/db"
      db: "nedb"
    _.merge(config, testing)

  #console.log config
  return config
