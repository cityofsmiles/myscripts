#!/usr/bin/sh

cd /home/jonathan/Documents/grade8-repository/assets/Grade8Lessons
	git add --all
	git commit -m "$1"
	git push -u origin assets

micro /home/jonathan/Documents/grade8-repository/master/README.md &&

cd /home/jonathan/Documents/grade8-repository/master
	git add --all
	git commit -m "$1"
	git push -u origin master

