# Collects all files in destDir, apart from index.html & writes appcache
# adds style.css
#

path            = require("path")
fs              = require('fs-extra')
globby          = require("globby")

now     = new Date().toISOString().slice(0, 19).replace(/:/g, "-")
destDir = path.join(__dirname, "/../server/public")

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

    # 5a. add style.css
    indexHtml = indexHtml.replace('</head>', '  <link rel="stylesheet" href="./dist/style.css">\n  </head>')
    # 5b. add meta data
    try
      appVersion = require("../package.json")?.version
      indexHtml = indexHtml.replace('<meta name="app-version" content="dev">', """<meta name="app-version" content="#{appVersion}">""")
      indexHtml = indexHtml.replace('<meta name="app-build-date" content="dev">', """<meta name="app-build-date" content="#{new Date().toISOString()}">""")

    fs.writeFileSync "#{destDir}/index.html", indexHtml

    # 6. build offline app with appcache enabled
    indexHtml = indexHtml.replace('<html lang="de">', """<html lang="de" manifest="/#{now}.appcache">""")

    fs.writeFileSync "#{destDir}/app.html", indexHtml

  catch err
    console.log "Can't create production app", err

createApp()
