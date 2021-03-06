#!/bin/bash

set -e
set -x

workdir=`pwd`
cd ~
home=`pwd`
home=${home//\//\\\/}
cd -

if [ `grep export /etc/profile | wc -l` -eq 0 ]
then
    echo "Insert env"
    cp /etc/profile pf
    sed "s/\~/${home}/g" ./go_env >> pf
    sudo mv pf /etc/profile
    source /etc/profile
fi

cd ~
if test ! -d go
then 
    git clone https://git.oschina.net/yyzybb537/go.git
else
    cd go
    git pull
    cd ~
fi

if [ `which go | wc -l` -eq 0 ]
then
    cp go go1.4 -r
    cd go1.4/src
    git checkout release-branch.go1.4
    ./all.bash
    cd -
    cd go/src
    git checkout release-branch.go1.7
    ./all.bash
    cd -
fi

#DIR=/usr/lib/go/src/golang.org/x
#mkdir -p $DIR
#cd $DIR
#test ! -d tools && git clone https://github.com/golang/tools.git
#
#cd $DIR/tools/cmd/gorename && go build && go install
#cd $DIR/tools/cmd/oracle && go build && go install

cd $workdir
./goenv.sh
