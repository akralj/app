# Initializes the `users` service on path `/users`
NeDb = require('nedb')
createService = require('feathers-nedb')

hooks = require('./users.hooks')


module.exports = (app) ->
  Model = new NeDb({
    filename: "#{app.serverConfig.dbRoot}/users.db"
    autoload: true
  })
  Model.ensureIndex({ fieldName: 'email', unique: true })

  options =
    name: 'users'
    Model: Model
    paginate:
      default: 100
      max: 100000

  # Initialize our service with any options it requires
  app.use '/api/users', createService(options)
  # Get our initialized service so that we can register hooks and filters
  service = app.service('/api/users')
  service.hooks hooks

