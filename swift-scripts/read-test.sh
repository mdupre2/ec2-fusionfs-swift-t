#!/bin/bash

# clears cache and performs read operation. Records the time it took to perform read and appends it /mnt/work/read-records

export TIMEFORMAT=%R
free && sync && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
echo -e "$(hostname)\t$(date +%s)\t$({ time dd if=$1 of=/dev/null bs=1M count=1024 iflag=fullblock 2> /dev/null; } 2>&1 )\t$(date +%s)" >> /mnt/work/read-records