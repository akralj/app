# Feathers Starter Kit & Vuetify Client

> app dev made easy


## Install prerequisites on dev machine and production server
- tested with ubuntu 16.04 and node 8.x

### Install node.js(8.x) and git
``` sh
# Install dependencies on ubuntu
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
# Install node and git
sudo apt-get install git nodejs
```

## First steps
#### Clone repos and install deps
```
git clone https://github.com/akralj/app {{yourAppName}}
cd {{yourAppName}}

### Install dependencies
npm install
```

#### Configure app
- change name, description & author in ./package.json. Name will be used in ./server/config.coffee
- change appPort to production port,... in ./server/config.coffee to match your enviroment

#### Start with a fresh git repo
```
rm -rf .git
git init
git add .
git commit -am "initial commit"
# Add your own remote origin
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

### IMPORTANT
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

### Step 1

run development instance
```
npm run dev &
npm run stage
```
go to http://devServer:7778 and /app.html if it's an offline app
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

Commit to dev
```gca "release-x.x.x - your comment" ```

Commit to master
```
git co master
git merge dev
git push origin master
git co dev
```

TODOS: add more docs like in: http://vuejs-templates.github.io/webpack/
