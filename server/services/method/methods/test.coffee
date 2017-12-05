#
#
#

path           = require("path")
_             = require("lodash")
feathersHooks = require("feathers-hooks-common")


module.exports = (app) ->
  methodFileName = path.basename(__filename, ".coffee")

  service =
    get: (id, params) ->
      Promise.resolve({
        id: id
        description: "You have to do #{id}!"
      })

  app.use("api/method/#{methodFileName}", service)

  # app.service("api/method/#{methodFileName}").hooks({})