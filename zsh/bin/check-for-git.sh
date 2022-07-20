#!/bin/bash

if [[ -e  "${1}/.git" ]]
then
	echo "$1"
fi
