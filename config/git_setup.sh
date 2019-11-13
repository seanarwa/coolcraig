#!/bin/sh

HELP_MANUAL="$(basename "$0") \"NAME\" \"EMAIL\" -- program to set up git credentials on new machine

where:
    NAME   is the name displayed on git
    EMAIL  is the email displayed on git"

GIT_NAME=$1
GIT_EMAIL=$2

if ! [ -x "$(command -v git)" ]; then
	echo 'ERROR: Git is not installed.' >&2
	exit 1
fi

if [ "$GIT_NAME" == "" ]; then
	echo "ERROR: Name is empty"
	echo "$HELP_MANUAL"
	exit 1
fi

if [ "$GIT_EMAIL" == "" ]; then
	echo "ERROR: Email is empty"
	echo "$HELP_MANUAL"
	exit 1
fi

git --version

git config --global user.name "$GIT_NAME"
echo "Git Credentials: user.name has been set to $GIT_NAME"

git config --global user.email "$GIT_EMAIL"
echo "Git Credentials: user.email has been set to $GIT_EMAIL"