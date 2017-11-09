# is populated by app-contacts and send data to selected consumers
# eg. web team
#

_             = require("lodash-mixins")
NeDb          = require('nedb')
service       = require('feathers-nedb')
feathersHooks = require("feathers-hooks-common")
hooks         = require('../../hooks')


module.exports = ->
  app = this
  collectionName = require("path").basename(__dirname)

  # decide if you want to use mongodb for this service in production here
  if app.serverConfig.db is "mongodb"
    MongoClient = require('mongodb').MongoClient
    service     = require('feathers-mongodb')
    mongodb     = await MongoClient.connect("#{app.serverConfig.dbPath}/#{app.serverConfig.appName}")
    db          = mongodb.collection(collectionName)
  else
    NeDb          = require('nedb')
    service       = require('feathers-nedb')
    db = new NeDb({filename: "#{app.serverConfig.dbRoot}/#{collectionName}.db", autoload: true})

  db.remove {}, { multi: true }, (err, res) ->
    data = require("./films.json")
    data.forEach((item) -> item._id = item.id)
    #console.log data.length
    db.insert data, (err, res) -> #console.log err, res

  opts =
    Model: db
    paginate:
      default: 100
      max: 100000


  app.use("api/#{collectionName}", service(opts))

  app.service("api/#{collectionName}").hooks({
    before:
      all: [hooks.changeId2_id, hooks.normalizeParams]
      patch:  feathersHooks.disallow('external')
      remove: feathersHooks.disallow('external')
      # WAF block all POSTS, PUTS so this is save and needed to be updated from admin server
      #update: feathersHooks.disallow('external')
      #create: feathersHooks.disallow('external')

    after:
      all: [hooks.change_id2id]

  })

