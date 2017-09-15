# sync config values of ./package.json with ./server/package.json, because some of them are used in production
# copies webix fonts to client/dist
#


fs    = require('fs-extra')

###################################################################################################
# sync package.json
###################################################################################################
# add props you want to see in ./server/package.json here
propsToOverwrite = ["name", "version", "author", "description", "config"]

json        = require("../package.json")
jsonServer  = require("../server/package.json")

for prop in propsToOverwrite
  jsonServer[prop] = json[prop] if json?[prop]

fs.writeFileSync("./server/package.json", JSON.stringify(jsonServer, null, 2) )


###################################################################################################
# copy fonts from webix/fonts to client/dist/fonts
###################################################################################################
# if you have to support really old browsers, eg. ie < 9 or android < 4.4, add more fonts
webixFonts = ["fontawesome-webfont.woff", "fontawesome-webfont.woff2", "PTS-bold.woff", "PTS-webfont.woff"]

webixProPath = "./node_modules/@xbs/webix-pro/fonts"
webixGplPath = "./node_modules/webix/fonts"

try
  fs.statSync webixProPath
  webixPath = webixProPath
catch err
  try
    fs.statSync webixGplPath
    webixPath = webixGplPath
  catch err
    console.log "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    console.log "ERRROR: Can't find webix fonts in", webixProPath, "or", webixGplPath
    console.log "Please do: npm install"
    console.log "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    process.exit()

for font in webixFonts
  fs.copySync("#{webixPath}/#{font}", "./client/dist/fonts/#{font}")

return
