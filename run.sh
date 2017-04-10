#!/bin/bash
set -e

if [[ -f env.sh ]] ; then
    source env.sh
    bin/hubot -a irc -n Tudebot
else
    echo "Please put your configuration in a file called env.sh (see env.sh.EXAMPLE)"
    exit 1
fi

