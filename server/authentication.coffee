{ AuthenticationService, JWTStrategy } = require('@feathersjs/authentication')
{ LocalStrategy } = require('@feathersjs/authentication-local')
{ expressOauth } = require('@feathersjs/authentication-oauth')

module.exports = (app) ->
  authentication = new AuthenticationService(app)

  authentication.register('jwt', new JWTStrategy())
  authentication.register('local', new LocalStrategy())

  app.use('/authentication', authentication)
  app.configure(expressOauth())
