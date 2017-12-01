# sync config values of ./package.json with ./server/package.json, because some of them are used in production
#
#

fs    = require('fs-extra')

###################################################################################################
# sync package.json
###################################################################################################
# add props you want to see in ./server/package.json here
propsToOverwrite = ["name", "version", "author", "description"]

json        = require("../package.json")
jsonServer  = require("../server/package.json")

for prop in propsToOverwrite
  jsonServer[prop] = json[prop] if json?[prop]

fs.writeFileSync("./server/package.json", JSON.stringify(jsonServer, null, 2) )
