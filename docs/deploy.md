# deploy
### First time
1. ssh sysadmin@prodServerName

2. create systemd script (https://www.digitalocean.com/community/tutorials/how-to-deploy-node-js-applications-using-systemd-and-nginx)

3. save in /etc/systemd/system/node-sample.service

4. enable & start
```
systemctl enable app-name
systemctl start app-name
```

5. add prodcution user systemd script rights to: /etc/sudoers.d/usersWithNoPassword
e.g. $username ALL=(ALL) NOPASSWD: /bin/journalctl -u app-name -f, /bin/systemctl status app-name, /bin/systemctl stop app-name, /bin/systemctl start app-name, /bin/systemctl restart app-name


6. logout sysadmin & ssh as user under which the service is run

7. get log files
```
sudo journalctl -u app-name -f
```
