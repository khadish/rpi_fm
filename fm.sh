#!/bin/bash


function play()
{
    if ping -c 1 -w 1 192.168.1.106 && ! ps -C mpg123
    then
            mpg123 $1
    fi
}
