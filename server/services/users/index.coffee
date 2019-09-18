# Initializes the `users` service on path `/users`

{ Service } = require('feathers-nedb')
Users = class Users extends Service

createModel = require('./users.model')
hooks = require('./users.hooks')

module.exports =  (app) ->
  Model = createModel(app)
  paginate = app.get('paginate')

  options = {
    Model: Model,
    paginate: paginate
  }

  # Initialize our service with any options it requires
  app.use('/users', new Users(options, app))

  # Get our initialized service so that we can register hooks
  service = app.service('users')

  service.hooks(hooks)
