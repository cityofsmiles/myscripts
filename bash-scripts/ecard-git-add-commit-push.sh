#!/usr/bin/sh

cd /home/jonathan/Documents/git-repos/ecard-2021/
zip ecard2021 *.xlsx *.py
mv ecard2021.zip /home/jonathan/Documents/grade8-repository/assets/Grade8Lessons/miscellaneous/

cd /home/jonathan/Documents/grade8-repository/assets/Grade8Lessons
	git add --all
	git commit -m "$1"
	git push -u origin assets


cd /home/jonathan/Documents/git-repos/ecard-2021/
	git add --all
	git commit -m "$1"
	git push -u origin main

