#!/usr/bin/env bash

realpass='example'

echo 'Content-type: text/plain'
echo ''

if [ -z $QUERY_STRING ]; then
    {}
else
    password=$(echo "$QUERY_STRING" | sed -n 's/^.*password=\([^&]*\).*$/\1/p' | sed "s/%20/ /g")
fi

if [ $realpass == $password ]; then
    sudo cp base.html base.html.backup
    sudo echo ''>base.html
    echo 'Ok, "base.html" cleared, copy in "base.html.backup"'
else
    echo 'Permission denied'
fi
