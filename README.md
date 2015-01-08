# private sls tree
for zhao's. contact fortable1999@gmail.com

## Content Table
1. [install salt](#install-salt)
2. [get sls tree](#get-sls-tree)
3. [salt master start](#salt-master-start)
4. [salt minion start](#salt-minion-start)
4. [execute SLS on minion](#execute-sls-on-minion)

## todo list:
1. use username/password auth
2. multi-client connection support

## install salt
```
sudo su -
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh git develop
```

## get sls tree
```
cd /srv
git clone https://github.com/fortable1999/salt-sls-zhao.git .  ``` 
## salt master start
```
salt-master -d
```

## salt minion start
```
vi /etc/salt/minion
# edit server host
# edit id
salt-minion -d
```

## accept minion key
```
# check all keys
salt-key -L

# accept all keys
salt-key -A
```

## upgrade packages
```
salt '*' pkg.refresh_db
salt '*' pkg.list_upgrades
```

## execute SLS on minion
```
salt '*' state.highstate
```
