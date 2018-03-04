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
  authentication:
    secret: "37a80af45ae2e1f5daf7af18750a4e1341c112e99e5137a05d2d86d5889ebbb3ce395bd376fbe563daf92b3ad49329df239d9ecc48407581dbb5f9d4ef4d26e157759d8de3ae0e0fcacb6124c45e1e27f1670666cfff1cc4eeeafdd32076f6831a68deeb310cf437e1c6b637269268124dcded33e949beae718286f3664ed25c3ae1ae890bb1c200eeed302d740cc42afac342d07e87f27c5bdfea87c27c7d9bcb0e784d40671a64a0facf033271bcd91a1c6e5d0cfe3b8cbe4311e559f278ba74f0572f130b2b4026cf8bfcefcff30a5ef408db81f893be3b82418d507274df815c54c845b84543551000a4c406c30fed18e6fb5b023b772436ab5e5518a046"
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
