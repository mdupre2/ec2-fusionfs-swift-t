#!/bin/bash

# clears cache and performs write operation. Records the time it took to perform write and appends it /mnt/work/write-records

export TIMEFORMAT=%R
free && sync && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
echo > $1
echo -e "$(hostname)\t$(date +%s)\t$({ time dd of=$1 if=/dev/zero  bs=1M count=1024 iflag=fullblock conv=fdatasync 2> /dev/null; } 2>&1 )\t$(date +%s)" >> /mnt/work/write-records

