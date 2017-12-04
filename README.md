# Feathers Starter Kit & BYO (bring your own client)

> app dev made easy


## Install prerequisites on dev machine and production server
- tested in ubuntu 16.04 and node 8.x

### Install node.js(8.x) and git
``` sh
# install dependencies on ubuntu
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get update
# install node and git
sudo apt-get install --yes git nodejs
```

## First steps
- change name, description & author in package.json -> this will be used in server/config.coffee
- change appPort to production port,... in server/config.coffee to match your enviroment
- start with a fresh git repo
```
rm -rf .git
git init
git add .
git commit -am "initial commit"
# add your own remote origin
git remote set-url origin ssh://git@YourSourcecodeServer/projectName/appName.git
git push origin
```

## Prepare Production Server
- see docs/deploy.md


# Note:
There are 3 package.json files in this project, in "./" , "./client/" and "./server/"

1. "./package.json" is used to build tools and npm scripts
2. "./client/package.json" is used for the client dependencies
3. "./server/package.json" is used for the server dependencies. Most other props are copied from ./package.json

- client dependencies are installed as in ../client
- server dependencies are installled as dependencies in ./server


# Development Workflow

run dev server
```
npm run dev
```

build and run "production" code on staging server on devServer:7778
useful for testing offline version, devServer:7778/app.html
```
npm run stage
```

# Production Workflow
### Step 0
change ./package.json version: to new release, eg. from release-0.1.1 to release-0.1.2
gca "release-x.x.x - your comment"

### Step 1

run development instance
```
npm run dev &
npm run stage
```
go to http://devServer:7778, /app.html
do manual tests from trello

### Step 2

create production app with the user context the service runs and you have ssh access.

```
DEPLOY_SSH=user@server npm run deploy
```
- builds client and copy client app to server/public
- rsync ./server to production server (prodServerName) (including node_modules, etc)
- stop and start app-{{appName}} (systemd) on production server

### Step 3

check if service running
```
ssh username@prodServerName
sudo journalctl -u app-name -f
```

### Step 4

Commit to master
```
git co master
git merge dev
git push origin master
git co dev
```

TODOS: add more docs like in: http://vuejs-templates.github.io/webpack/
