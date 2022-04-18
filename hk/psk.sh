#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/env.sh

if [[ ! -e $SECRETSFILE ]] || [[ ! -r $SECRETSFILE ]] || [[ ! -w $SECRETSFILE ]]; then
    echo "$SECRETSFILE is not exist or not accessible (are you root?)"
    exit 1
fi

PSK='123456'

# comment existing PSK
sed -i -e "/[[:space:]]\+PSK[[:space:]]\+/s/^/# /" $SECRETSFILE

echo -e "\n%any %any : PSK \"$PSK\"" >> $SECRETSFILE

echo "$SECRETSFILE updated!"
