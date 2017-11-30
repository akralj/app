# Deploy Steps on Systemd Systems

### First time
0. ssh sysadmin@prodServerName

1. create directory
```sudo mkdir /apps/{{appName}}```

2. create systemd script (https://www.digitalocean.com/community/tutorials/how-to-deploy-node-js-applications-using-systemd-and-nginx)
``` cp ./docs/systemd-example.service /etc/systemd/system/app-{{appName}}.service ```
- change handlebared values

3. save in /etc/systemd/system/app-{{appName}}.service

4. enable & start
```
sudo systemctl enable app-{{appName}}
```

5. add prodcution user systemd script rights to: /etc/sudoers.d/usersWithNoPassword
```sudo nano /etc/sudoers.d/usersWithNoPassword```

e.g. {{userName}} ALL=(ALL) NOPASSWD: /bin/journalctl -u app-{{appName}} -f, /bin/systemctl status app-{{appName}}, /bin/systemctl stop app-{{appName}}, /bin/systemctl start app-{{appName}}, /bin/systemctl restart app-{{appName}}


6. logout sysadmin & ssh as user under which the service is run

7. get log files
```
sudo journalctl -u app-{{appName}} -f
```

8. deploy app from dev machine for the first time
``` DEPLOY_SSH=userName@server npm run deploy ```
