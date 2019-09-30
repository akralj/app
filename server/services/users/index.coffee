# Initializes the `users` service on path `/users`

{ Service } = require('feathers-nedb')
Users = class Users extends Service

createModel = require('./users.model')
hooks = require('./users.hooks')

module.exports =  (app) ->
  opts =
    Model: createModel(app)
    paginate: app.serverConfig.paginate

  # Initialize our service with any options it requires
  app.use('/users', new Users(opts, app))

  # Get our initialized service so that we can register hooks
  service = app.service('users')

  service.hooks(hooks)
