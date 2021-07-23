#!/usr/bin/bash

device="$1"
devicepartition="$2"

sudo parted /dev/$device rm $devicepartition

sudo parted /dev/$device mkpart primary ext4 0 100%

sudo mkfs -V -t ext4 /dev/$device$devicepartition


