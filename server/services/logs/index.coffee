# logger endpoint which should be used for important events
#
#

_             = require("lodash")
NeDb          = require("nedb")
service       = require("feathers-nedb")
hooks         = require("../../hooks")
feathersHooks = require("feathers-hooks-common")
Joi           = require("joi")

schema = Joi.object().keys({
  #id:                 Joi.string().required()
  dt:                 Joi.string().allow("").isoDate().default(new Date().toISOString())
  level:              Joi.valid("info", "error", "warning", "userError").default("info")
  event:              Joi.object().keys({}).default({})
  source:             Joi.string().min(1).trim().allow("").default("")
  message:            Joi.string().min(1).trim().allow("").default("")
  #context:            Joi.object().keys({}).default({})
  #details:            Joi.object().keys({}).default({})
}).options({ convert: true, abortEarly: false, stripUnknown: { arrays: false, objects: true } })

module.exports = (app) ->
  collectionName = require("path").basename(__dirname)

  db = new NeDb({ filename: "#{app.serverConfig.dbRoot}/logs.db", autoload: true })

  validate =
    (hook) ->
      #console.log hook.params
      data = hook?.data or {}
      Joi.validate data, schema, (err, value) ->
        if err
          Promise.reject(new errors.Unprocessable(err.name, { errors: err.details }))
        else
          #console.log value
          hook.data = value
          Promise.resolve(hook)

  opts =
    Model: db
    paginate: app.serverConfig.services.paginate

  app.use("api/#{collectionName}", service(opts))

  app.service("api/#{collectionName}").hooks({
    before:
      create: [ validate ]
      all:    [hooks.changeId2_id]
      update: [feathersHooks.disallow("external")]
    after:
      all: [hooks.change_id2id]
  })
