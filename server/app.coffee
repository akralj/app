# main server file
# modeled after: https://github.com/feathersjs/feathers-chat
#

feathers      = require('feathers')
rest          = require('feathers-rest')
socketio      = require('feathers-socketio')
hooks         = require('feathers-hooks')
compression   = require('compression')
bodyParser    = require('body-parser')
cors          = require('cors')
path          = require('path')
middleware    = require('./middleware')

promisedApp = new Promise (resolve) ->

  # Create a feathers instance.
  app = feathers()
  # add global serverConfig which can be used in services
  app.serverConfig = require("./config")(process.env.APP_ENV)

  app.use(compression())
  .options('*', cors()).use(cors()) # needed for tests
  .use("/", feathers.static(app.serverConfig.clientCode))

  .use(bodyParser.json())
  .use(bodyParser.urlencoded(extended: true))
  .configure(hooks())
  .configure(socketio())
  .configure(rest())
  .configure(require('./services/config'))
  .configure(require('./services/data'))

  .configure(middleware)

  resolve app

# export app to be used for dev, production, testing, ...
module.exports = promisedApp
