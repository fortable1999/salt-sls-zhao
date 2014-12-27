# private sls tree
for zhao's

## Content Table
1. [install salt](#install)
2. [get sls tree](#get-sls)
3. [salt master start](#master-start)
4. [salt minion start](#minion-start)
4. [execute SLS on minion](#highstate)

## install salt [install]
```
sudo su -
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh git develop
```

## get sls tree [get-sls]
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

## execute SLS on minion [highstate]
```
salt '*' state.highstate
```
