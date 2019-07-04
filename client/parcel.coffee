# This is needed to get appPort from main server config
# Proxy /api and /assets requests to server app
#
#


Bundler = require('parcel-bundler')
express = require('express')
proxy = require('http-proxy-middleware')

# get serverPort from main server/config.coffee
try
  serverConfig = require("../server/config")("development")
  serverPort = serverConfig.appPort
catch error
  # default serverPort if serverConfig is missing or no server part in project
  # access app at: http://localhost:7777
  serverPort = 7778


app = express()
app.use '/api'    , proxy(target: "http://localhost:#{serverPort}")
app.use '/assets' , proxy(target: "http://localhost:#{serverPort}")
bundler = new Bundler('src/index.html')
app.use bundler.middleware()
app.listen(serverPort - 1 )
