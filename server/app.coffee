# main server file
# modeled after: https://github.com/feathersjs/feathers-chat
#

feathers      = require("@feathersjs/feathers");
express       = require("@feathersjs/express");
socketio      = require("@feathersjs/socketio")
compression   = require("compression")
cors          = require("cors")
middleware    = require("./middleware")

promisedApp = new Promise (resolve) ->

  # Create a feathers instance.
  app = express(feathers())
  # add global serverConfig which can be used in services
  app.serverConfig = require("./config")(process.env.APP_ENV)

  app.use(compression())
  .options("*", cors()).use(cors()) # needed for tests
  .use("/", express.static(app.serverConfig.clientCode))
  .use(express.json())
  .use(express.urlencoded(extended: true))
  .configure(socketio())
  .configure(express.rest())
  .configure(require("./services/config"))
  .configure(require("./services/data"))
  .configure(middleware)

  resolve app

# export app to be used for dev, production, testing, ...
module.exports = promisedApp
