# private sls tree
for zhao's

## Content Table
1. [install salt](#install-salt)
2. [get sls tree](#get-sls-tree)
3. [salt master start](#salt-master-start)
4. [salt minion start](#salt-minion-start)
4. [execute SLS on minion](#execute-sls-on-minion)

## install salt
```
sudo su -
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh git develop
```

## get sls tree
```
cd /svr
git clone git@github.com:fortable1999/salt-sls-zhao.git
```

## start salt server
```
salt-master
```

## start salt client
```
vi /etc/salt/minion
# edit server host
# edit id
salt-minion
```

## execute SLS on minion
```
salt '*' state.highstate
```
