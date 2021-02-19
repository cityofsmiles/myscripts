#!/usr/bin/bash

device="$1"
devicefirstpartition="$2"

sudo parted /dev/$device --script -- mklabel gpt

sudo parted /dev/$device --script -- mkpart primary ext4 0% 100%

sudo mkfs.ext4 -F /dev/$devicefirstpartition

sudo parted /dev/$device --script print

