# main server file
# modeled after: https://github.com/feathersjs/feathers-chat
#

feathers      = require("@feathersjs/feathers")
express       = require("@feathersjs/express")
socketio      = require("@feathersjs/socketio")
# helmet = require('helmet') # for app protection. try it out some day
compression   = require("compression")
cors          = require("cors")
path          = require("path")
fs            = require("fs")
logger        = require('./logger')
middleware    = require("./middleware")
appHooks      = require('./app.hooks')
authentication = require('./authentication')

# client dev server (parcel bundler with HMR)
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
  # set authentication config to app root
  app.set('authentication', app.serverConfig.authentication)

  # app.use(helmet())
  app.use(compression())
  app.options("*", cors()).use(cors()) # needed for tests

  # create assets dir if it does not exists and create a route for it
  assetsDir = path.join(__dirname, "../assets")
  fs.mkdirSync assetsDir unless fs.existsSync(assetsDir)
  app.use("/assets", express.static(assetsDir))
  # static app assets
  app.use("/", express.static(path.join(__dirname, "./public")))

  app.use(express.json())
  app.use(express.urlencoded({ extended: true }))
  app.configure(express.rest())
  app.configure(socketio())

  # Configure other middleware (see `middleware/index.js`)
  app.configure(middleware)
  app.configure(authentication)
  
  # add all endpoints
  app.configure(require("./services/config"))
  app.configure(require("./services/users"))
  app.configure(require("./services/logs"))
  app.configure(require("./services/data"))
  app.configure(require("./services/method"))

  # add jobs to app
  app.configure(require('./jobs/'))

  # parcel serves client files in dev mode
  if process.env.APP_ENV is "development"
    app.use bundler.middleware()
  # default is always static files to be sure it is correct in production
  else
    app.use("/", express.static(path.join(__dirname, "./public")))
    # Configure a middleware for 404s and the error handler (only in production, 'cause we want the errors in dev)
    app.use(express.notFound())
    app.use(express.errorHandler({ logger }))
    
  # Application hooks that run for every service
  app.hooks(appHooks)
  #app.configure(middleware)

  resolve app

# export app to be used for dev, production, testing, ...
module.exports = promisedApp
