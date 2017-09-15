# these values are send to client as /config
# and can bei user edited if allowed in ./index.coffee
#

# some serverConfig values go to client too
serverConfig = require("../../config")

module.exports = (env) -> [
  {
    id: "general"
    data: [
      {
        id: "imageUrl",
        displayName: "Base Url der Bilder"
        value: serverConfig(env).services.contacts.imageUrl
      }
    ]
  }
  {
    id: "bookingTime"
    data: [
      {
        id: "09",
        value: "09:00"
      },
      {
        id: "12",
        value: "12:00"
      },
      {
        id: "15",
        value: "15:00"
      }
    ]
  }
]
