#
#
#

_             = require("lodash")
axios         = require("axios")
fs            = require("fs")
promisify     = require("util").promisify
writeFile     = promisify(require("fs").writeFile)


getData = (args) ->
  { app } = args

  # do some async work (add your own code here)
  result = await axios.get("http://localhost:#{app.get("port")}/api/config")

  return { message: "successful job", numberOfRecords: result.data.data.length }


module.exports = getData