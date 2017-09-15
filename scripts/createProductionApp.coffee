# TODO build client files here
# Collects all files in srcDir, apart from index.html
# writes appcache


fs      = require('fs-extra')
glob    = require("glob")

now     = new Date().toISOString().slice(0, 19).replace(/:/g, "-")
srcDir  = "./client/dist"
destDir = "./server/public"

# sync ./package.json and ./server/package.json
require("./bootstrapDevEnv")


glob "#{srcDir}/**/*.*", {}, (err, files) ->
  if files
    appCacheFiles = files
      .filter (file) -> not file.match(/index.html/)
      .map (file) -> file.replace(srcDir, "")
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

    # 1. cleanup directory
    fs.emptyDirSync(destDir)

    # 2. copy dist to public
    fs.copySync("client/dist/", "server/public/")

    # 3. write appcache file
    console.log "generated appcache: #{new Date}"
    fs.writeFileSync "#{destDir}/#{now}.appcache", appcacheTemplate

    # 4. write appcache enabled app.html
    indexHtml = fs.readFileSync "#{destDir}/index.html", "utf8"

    # 5. build offline app with appcache enabled
    indexHtml = indexHtml
      .replace('<html lang="de">', """<html lang="de" manifest="/#{now}.appcache">""")
    fs.writeFileSync "#{destDir}/app.html", indexHtml

  else
    console.log "Can't create production app", err
