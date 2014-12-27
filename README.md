# private sls tree
for zhao's

## install salt
```
sudo su -
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh git develop
```

## get sls tree3
```
cd /svr
git clone git@github.com:fortable1999/salt-sls-zhao.git
```

## start salt server
```
salt-master
```

## start salt client(option)
```
vi /etc/salt/minion
# edit server host
# edit id
salt-minion
```
