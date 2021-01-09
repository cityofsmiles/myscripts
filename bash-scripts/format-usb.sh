#!/usr/bin/bash

sudo parted /dev/sdb --script -- mklabel gpt

sudo parted /dev/sdb --script -- mkpart primary ext4 0% 100%

sudo mkfs.ext4 -F /dev/sdb1

sudo parted /dev/sdb --script print

