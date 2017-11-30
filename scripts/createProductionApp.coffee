# TODO build client files here
# adds style.css
# Collects all files in destDir, apart from index.html & writes appcache

path            = require("path")
fs              = require('fs-extra')
glob            = require("glob")
del             = require("del")

now     = new Date().toISOString().slice(0, 19).replace(/:/g, "-")
destDir = path.join(__dirname, "/../server/public")

# sync ./package.json and ./server/package.json
require("./bootstrapDevEnv")

# 1. cleanup public production dir. !!! keeps only assets folder alive !!!
del.sync(["#{destDir}/**", "!#{destDir}", "!#{destDir}/assets"])


# 2. copy client files to public
fs.copySync("client/index.html", "server/public/index.html")
fs.copySync("client/dist/", "server/public/dist/")
fs.copySync("client/static/", "server/public/static/")


glob "#{destDir}/**/*.*", {}, (err, files) ->
  if files
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

  else
    console.log "Can't create production app", err
