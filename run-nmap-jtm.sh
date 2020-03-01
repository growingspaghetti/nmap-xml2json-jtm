#!/bin/bash

# https://stackoverflow.com/questions/22009364/is-there-a-try-catch-command-in-bash
function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function catch()
{
    export ex_line=$?
    (( $SAVED_OPT_E )) && set +e
    return $ex_line
}

try
(
    nmap -p 443  yahoo.co.jp  -oX - | ./jtm-linux-64.v2.09 -r  || exit 19
    nmap -p 80   google.com   -oX - | ./jtm-linux-64.v2.09 -r  || exit 20
    nmap -p 22   localhost    -oX - | ./jtm-linux-64.v2.09 -r  || exit 21
    nmap -p 443  google.com   -oX - | ./jtm-linux-64.v2.09 -r  || exit 22
)
catch || {
    echo "syntax error at $ex_line"
    exit 1
}
