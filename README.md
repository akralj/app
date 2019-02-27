# Feathers Starter Kit & Vuetify or Framework7-Vue Client 

> app dev made easy


## Install prerequisites on dev machine and production server
- tested with ubuntu 16.04 and node 8.x or 10.x

### Install node.js(8.x or 10.x) and git
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
git remote add origin ssh://git@YourSourcecodeServer/projectName/appName.git
git push -u origin master
```

## Prepare Production Server
- see docs/deploy.md


# Note:
There are 2 package.json files in this project, in "./" and "./client/"

1. "./package.json" is used for server dependencies (dependencies), build tools and npm scripts (devDependencies)
2. "./client/package.json" is used for the client dependencies

### IMPORTANT
- Please install client dependencies in ../client


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
or configure DEPLOY_SSH in ./jobs/uploadAndRestartApp.sh

- builds client and copy client app to server/public
- rsync ./server, ./node_modules and ./package.json to production server (prodServerName)
- stop and start app-{{appName}} (systemd) on production server

### Step 3

check if service running
```
ssh username@prodServerName
sudo journalctl -u app-{{appName} -f
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
