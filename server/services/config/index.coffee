#
#
#

_             = require('underscore')
hooks         = require('../../hooks')
feathersHooks = require("feathers-hooks-common")


module.exports = (app) ->
  collectionName = require("path").basename(__dirname)

  # decide if you want to use mongodb for this service in production here
  if app.serverConfig.db is "mongodb"
    MongoClient = require('mongodb').MongoClient
    service     = require('feathers-mongodb')
    mongodb     = await MongoClient.connect(app.serverConfig.dbPath)
    db          = mongodb.collection(collectionName)
  else
    NeDb          = require('nedb')
    service       = require('feathers-nedb')
    db = new NeDb({ filename: "#{app.serverConfig.dbRoot}/#{collectionName}.db", autoload: true })

  # put clientConfigDefault values in and remove in production if you want
  # to allow users to change settings from client
  db.remove {}, { multi: true }, (err, res) ->
    clientConfig = require("./clientConfigDefault")(app.env).map (item) -> { _id: item.id, data: item.data }
    db.insert clientConfig, (err, res) -> #console.log err, res

  opts =
    Model: db
    paginate: app.serverConfig.paginate


  app.use("api/#{collectionName}", service(opts))

  app.service("api/#{collectionName}").hooks({

    before:
      all: [hooks.changeId2_id]
      # disallow all edit methods. uncomment if users should be allowed to change settings
      create: feathersHooks.disallow('external')
      update: feathersHooks.disallow('external')
      remove: feathersHooks.disallow('external')
      patch:  feathersHooks.disallow('external')

    after:
      all: [hooks.change_id2id]

  })
