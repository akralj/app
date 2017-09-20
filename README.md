# Feathers Starter Kit & BYO (bring your own client)

> app dev made easy

docs like in: http://vuejs-templates.github.io/webpack/


# Note:
There are two package.json files in this project, one in ./ and one in ./server/
./package.json is used for the client dependencies and npm scripts
./server/package.json is used for the server dependencies. Most other props are copied from ./package.json
- client dependencies are installed as devDependencies in ../app-client
- server dependencies are installled as dependencies in ./server


# Development Workflow

run dev server on devServer:7777 (or whatever devServer you choose in ./package.json)
``` sh
npm run dev
```

build and run "production" code on staging server on devServer:8888
useful for testing offline version, devServer:8888/app.html
``` sh
npm run stage
```

# Production Workflow
### Step 0
change server/package.json version: to new release, eg. from release-0.1.1 to release-0.1.2
gca "release-x.x.x - your comment"

### Step 1

run development instance
``` sh
npm run dev &
npm run stage
```
go to http://devServer:8888, /app.html
do manual tests from trello

### Step 2

create production app

``` sh
npm run deploy
```
- build and copy client app to server/public
- rsync ./server to production server (prodServerName) (including node_modules, etc)
- stop and start app-contacts (systemd) on production server

### Step 3

check if service running
``` sh
ssh username@prodServerName
sudo journalctl -u app-name -f
```


### Step 4

Commit to master
``` sh
git co master
git merge dev
git push origin master
git co dev

```
