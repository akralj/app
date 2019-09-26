{ AuthenticationService, JWTStrategy } = require('@feathersjs/authentication')
{ LocalStrategy } = require('@feathersjs/authentication-local')
{ expressOauth, OAuthStrategy } = require('@feathersjs/authentication-oauth')

# get profile data from github. default email value is not to show it to external services
class GitHubStrategy extends OAuthStrategy
  getEntityData: (profile) ->
    baseData = await super.getEntityData(profile)
    return { baseData..., email: profile.email }


module.exports = (app) ->
  authentication = new AuthenticationService(app)

  authentication.register('jwt', new JWTStrategy())
  authentication.register('local', new LocalStrategy())
  authentication.register('github', new GitHubStrategy())

  app.use('/authentication', authentication)
  app.configure(expressOauth())


###
# create user
curl 'http://localhost:7777/users/' -H 'Content-Type: application/json' --data-binary '{ "email": "hello@feathersjs.com", "password": "supersecret" }'
# authenticate
curl 'http://localhost:7777/authentication/' -H 'Content-Type: application/json' --data-binary '{ "strategy": "local", "email": "hello@feathersjs.com", "password": "supersecret" }'

###
