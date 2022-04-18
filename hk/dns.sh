#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/env.sh

if [[ ! -e $PPPCONFIG ]] || [[ ! -r $PPPCONFIG ]] || [[ ! -w $PPPCONFIG ]]; then
    echo "$PPPCONFIG is not exist or not accessible (are you root?)"
    exit 1
fi

DNS1="8.8.8.8"
DNS2="8.8.4.4"

sed -i -e "/ms-dns/d" $PPPCONFIG

echo "ms-dns $DNS1" >> $PPPCONFIG
echo "ms-dns $DNS2" >> $PPPCONFIG

echo "$PPPCONFIG updated!"
