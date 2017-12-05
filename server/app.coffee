# main server file
# modeled after: https://github.com/feathersjs/feathers-chat
#

feathers      = require("@feathersjs/feathers")
express       = require("@feathersjs/express")
socketio      = require("@feathersjs/socketio")
compression   = require("compression")
cors          = require("cors")
path          = require("path")
middleware    = require("./middleware")
fs            = require("fs")


promisedApp = new Promise (resolve) ->
  # Create a feathers instance.
  app = express(feathers())
  # add global serverConfig which can be used in services
  app.serverConfig = require("./config")(process.env.APP_ENV)

  app.use(compression())
  app.options("*", cors()).use(cors()) # needed for tests

  # create assets dir if it does not exists and create a route for it
  assetsDir = path.join(__dirname, "../assets")
  fs.mkdirSync assetsDir unless fs.existsSync(assetsDir)
  app.use("/assets", express.static(assetsDir))
  # static app assets
  app.use("/", express.static(path.join(__dirname, "./public")))
  app.use(express.json())
  app.use(express.urlencoded(extended: true))
  app.configure(socketio())
  app.configure(express.rest())
  app.configure(require("./services/config"))
  app.configure(require("./services/data"))
  app.configure(require("./services/method"))
  app.configure(middleware)

  resolve app

# export app to be used for dev, production, testing, ...
module.exports = promisedApp
