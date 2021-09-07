#!/usr/bin/bash

device="$1"
devicepartition="$2"

#sudo parted /dev/$device --script -- mklabel gpt

#sudo parted /dev/$device --script -- mkpart primary ntfs 0% 100%
#sudo parted /dev/$device --script -- mkpart primary ext4 0% 100%

#sudo mkfs.ext4 -F /dev/$devicefirstpartition
#sudo mkfs.ntfs -F /dev/$devicefirstpartition

#sudo parted /dev/$device --script print


sudo parted /dev/$device rm $devicepartition

sudo parted /dev/$device mkpart primary ntfs 0 100%

sudo mkfs -V -t ntfs /dev/$device$devicepartition
