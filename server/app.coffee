# main server file
# modeled after: https://github.com/feathersjs/feathers-chat
#

feathers      = require("@feathersjs/feathers")
express       = require("@feathersjs/express")
socketio      = require("@feathersjs/socketio")
compression   = require("compression")
cors          = require("cors")
path          = require("path")
fs            = require("fs")
middleware    = require("./middleware")
# client dev server
Bundler = require('parcel-bundler')
bundler = new Bundler(path.join(__dirname, '../client/src/index.html'), {
  outDir:     "client/dist"
  cacheDir:   "client/.cache"
  hmr:        true
  hmrPort:    0
})


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
  
  # add all endpoints
  app.configure(require("./services/config"))
  app.configure(require("./services/logs"))
  app.configure(require("./services/data"))
  app.configure(require("./services/method"))

  # add jobs to app
  app.configure(require('./jobs/'))

  if process.env.APP_ENV is "production" or process.env.APP_ENV is "staging"
    app.use("/", feathers.static(path.join(__dirname, "./public")))
  # parcel serves client files in dev mode
  else app.use bundler.middleware()

  # errors, logging,...
  app.configure(middleware)

  resolve app

# export app to be used for dev, production, testing, ...
module.exports = promisedApp
