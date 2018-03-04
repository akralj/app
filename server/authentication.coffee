#
#
#

authentication  = require('@feathersjs/authentication')
jwt             = require('@feathersjs/authentication-jwt')
local           = require('@feathersjs/authentication-local')


module.exports = (app) ->
  config = app.serverConfig.authentication

  # Set up authentication with the secret
  app.configure authentication(config)
  app.configure jwt()
  app.configure local()

  # The `authentication` service is used to create a JWT.
  # The before `create` hook registers strategies that can be used
  # to create a new valid JWT (e.g. local or oauth2)
  app.service('/api/authentication').hooks before:
    create: [ authentication.hooks.authenticate(config.strategies) ]
    remove: [ authentication.hooks.authenticate('jwt') ]