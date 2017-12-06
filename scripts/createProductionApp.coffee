# Collects all files in destDir, apart from index.html & writes appcache
# adds style.css
#

path            = require("path")
fs              = require('fs-extra')
globby          = require("globby")

now     = new Date().toISOString().slice(0, 19).replace(/:/g, "-")
destDir = path.join(__dirname, "/../server/public")

# sync ./package.json and ./server/package.json
propsToOverwrite  = ["name", "version", "author", "description"]
json              = require("../package.json")
jsonServer        = require("../server/package.json")
for prop in propsToOverwrite
  jsonServer[prop] = json[prop] if json?[prop]

fs.writeFileSync("./server/package.json", JSON.stringify(jsonServer, null, 2) )

# 1. cleanup public (=destDir) folder
fs.emptyDirSync(destDir)

# 2. copy client files to public
fs.copySync("client/index.html", "#{destDir}/index.html")
fs.copySync("client/dist/", "#{destDir}/dist/")
fs.copySync("client/static/", "#{destDir}/static/")

createApp = ->
  try
    files = await globby("#{destDir}/**/*.*")
    appCacheFiles = files
      .filter (file) -> not file.match(/index.html/)
      .map (file) -> file.replace(destDir, "")
      .join("\n")

    # add resources which need to be cached here
    appcacheTemplate =
    """
      CACHE MANIFEST
      # #{now}

      CACHE:
      /app.html
      #{appCacheFiles}
      NETWORK:
      *

      FALLBACK:
      / /app.html
    """

    # 3. write appcache file
    console.log "generated appcache: #{new Date}"
    fs.writeFileSync "#{destDir}/#{now}.appcache", appcacheTemplate

    # 4. write appcache enabled app.html
    indexHtml = fs.readFileSync "#{destDir}/index.html", "utf8"

    # 5. add style.css
    indexHtml = indexHtml.replace('</head>', '  <link rel="stylesheet" href="./dist/style.css">\n  </head>')
    fs.writeFileSync "#{destDir}/index.html", indexHtml

    # 5. build offline app with appcache enabled
    indexHtml = indexHtml.replace('<html lang="de">', """<html lang="de" manifest="/#{now}.appcache">""")

    fs.writeFileSync "#{destDir}/app.html", indexHtml

  catch err
    console.log "Can't create production app", err

createApp()
