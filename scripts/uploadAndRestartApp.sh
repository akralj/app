#!/bin/env bash
# DEPLOY_SSH=xnet@diolapp02 npm run deploy

# 1. get name prop from package.json
APP_NAME="$(node -pe "require('./package.json')['name']")"
DEPLOY_SSH="xnet@diolapp02" 


if [ -n "$DEPLOY_SSH" ]
then
  # 2. copy server app to production
  rsync -avh --stats --delete server/ $DEPLOY_SSH:/apps/$APP_NAME/server
  # 3. restart systemd service on production server
  ssh $DEPLOY_SSH "sudo systemctl stop app-$APP_NAME; sudo systemctl start app-$APP_NAME"

else
  echo "Please set DEPLOY_SSH=ssh path to server, e.g. DEPLOY_SSH=user@server.domain.at npm run deploy"
fi
