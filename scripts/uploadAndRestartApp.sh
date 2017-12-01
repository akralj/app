#!/usr/bin/env bash

# 1. get name prop from package.json
APP_NAME="$(node -pe "require('./package.json')['name']")"

# 2. copy server app to production
rsync -avh --stats --delete --exclude 'public/assets' server/ $DEPLOY_SSH:/apps/$APP_NAME/server

# 3. restart systemd service on production server
ssh $DEPLOY_SSH "sudo systemctl stop app-$APP_NAME; sudo systemctl start app-$APP_NAME"
