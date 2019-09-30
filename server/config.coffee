# Main config file
# Add everything here, what server code depends on
#

path        = require("path")
_           = require("lodash")

config = {
  port: 7777 # CHANGE TO PRODUCTION PORT HERE
  host: "localhost"
  public: "../server/public"
  paginate:
    default: 44
    max: 444

  # configure database server here. default is nedb
  db: "nedb" # ["nedb", "mongodb"]
  dbPath: "<mongodb://localhost:27017/databaseName>" # CHANGE TO YOUR MONGO DB NAME
  dbRoot: path.join(__dirname, "../db") # for nedb

  mail:
    server:
      host: '<smtp.yourServerName.at>'
      port: 25
  
  services:
    paginate:
      default: 44
      max: 444
    contacts:
      imageFolder: "/apps/assets/images/contact"
      imageUrl: "/assets/images/contact"

  authentication:
    entity: "user",
    service: "users",
    secret: "<change me>", # get this from env var, e.g. "0EuWRCdfaTtF4Atpi8DHbhPoFu4="
    authStrategies: ["jwt", "local"]
    jwtOptions:
      header:
        typ: "access"
      audience: "<https://add-your-domain-here.com>",
      issuer: "feathers"
      algorithm: "HS256"
      expiresIn: "1d"
    local:
      usernameField: "email"
      passwordField: "password"
    oauth:
      redirect: "/"
      github:
        key: "<github oauth key>",
        secret: "<github oauth secret>"
    groups:
      readOnlyGroups: ["<someGroup_r>", "<anotherGroup_r>"]
      readWriteGroups: ["<someOtherGroup_rw>"]

}

# merge config with production config, which can come from env var
try
  productionConfig = require(process.env.APP_CONFIG_PATH)
  config = _.merge(config, productionConfig)


module.exports = (env) ->
  if env is "development"
    development =
      db: "nedb"
    _.merge(config, development)
  
  else if env is "staging"
    staging =
      port: port + 1
      dbRoot: "./test/db"
      db: "nedb"
    _.merge(config, staging)

  else if env is "testing"
    testing=
      port: port + 2
      dbRoot: "./test/db"
      db: "nedb"
    _.merge(config, testing)

  #console.log JSON.stringify(config, null, 2)
  return Object.freeze(config)
